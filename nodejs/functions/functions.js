const { Op } = require("sequelize");
const path = require('path');
const e = require("express");
const wo_hashtags = require("../models/wo_hashtags");
const md5 = require('md5');
const moment = require('moment');
const striptags = require('striptags');
const wo_userschat = require("../models/wo_userschat");
let Handlebars = require("handlebars")
let fs = require("fs")

let audio;
let chat_audio;
let chat_video;

let audioTemplate;
let chatAudioTemplate;
let chatVideoTemplate;


function getAudioTemplate(mediaFileName) {
    return audioTemplate({
        fileName: mediaFileName
    })
}

function getChatAudioTemplate(mediaFileName) {
    return chatAudioTemplate({
        fileName: mediaFileName
    })
}


function getChatVideoTemplate(mediaFileName) {
    return chatVideoTemplate({
        fileName: mediaFileName
    })
}

class FunctionsUtils {
    async DefineAudioTemplates() {
        audio = fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/audio.html'));
        chat_audio = fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/chat-audio.html'));
        chat_video = fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/chat-video.html'));

        audioTemplate = Handlebars.compile(audio.toString());
        chatAudioTemplate = Handlebars.compile(chat_audio.toString());
        chatVideoTemplate = Handlebars.compile(chat_video.toString());
    }
    async Wo_Markup(ctx, text) {
        let link = true, hashtag = true, mention = true, post_id = 0, comment_id = 0, reply_id = 0
        if (mention) {
            let Orginaltext = text;
            // let mention_regex = new RegExp('', 'gi');
            let mention_matches = text.match(/@\[([0-9]+)\]/gi)
            if (mention_matches) {
                for (let match of mention_matches) {
                    let mentionUser = await ctx.wo_users.findOne({
                        where: {
                            user_id: match.substr(2).slice(0, -1)
                        }
                    })
                    if (mentionUser) {
                        let match_search = match;
                        if (mentionUser['user_id']) {
                            mentionUser = await this.Wo_UserData(ctx, mentionUser.user_id)
                            let match_replace = '<span class="user-popover" data-id="' + mentionUser['user_id'] + '" data-type="user"><a href="index.php?link1=timeline&u=' + mentionUser.username + '" class="hash" data-ajax="?link1=timeline&u=' + mentionUser['username'] + '">' + mentionUser['name'] + '</a></span>';
                            text = text.replace(match_search, match_replace);
                        }
                        else {
                            let match_replace = '';
                            Orginaltext = Orginaltext.replace(match_search, match_replace);
                            text = text.replace(match_search, match_replace);
                        }
                    }
                }
            }
        }
        if (link) {
            let link_matches = text.match(/\[a\](.*?)\[\/a\]/i);
            do {
                if (link_matches && link_matches[1]) {
                    let match_decode = unescape(link_matches[1]);

                    text = text.replace('[a]' + link_matches[1] + '[/a]', '<a href="' + striptags(match_decode) + '" target="_blank" class="hash" rel="nofollow">' + match_decode + '</a>');
                }
                link_matches = text.match(/\[a\](.*?)\[\/a\]/i);
            } while (link_matches)
        }
        if (hashtag) {
            // let hashtag_regex = new RegExp(, 'gi');
            let matches = text.match(/(#\[([0-9]+)\])/gi);
            if (matches) {
                for (let match of matches) {
                    let hashdata = await this.Wo_GetHashtag(ctx, (+match.substr(2).slice(0, -1)));
                    if (hashdata) {
                        let hashlink = '<a href="index.php?link1=hashtag&hash=' + hashdata['tag'] + '" class="hash">#' + hashdata['tag'] + '</a>';
                        text = text.replace(/(#\[([0-9]+)\])/gi, hashlink);
                    }
                }
            }
        }
        return text;
    }
    async updateOrCreate(model, where, newItem) {
        // First try to find the record
        const foundItem = await model.findOne({ where });
        if (!foundItem) {
            // Item not found, create a new one
            const item = await model.create(newItem)
            return { item, created: true };
        }
        // Found an item, update it
        const item = await model.update(newItem, { where });
        return { item, created: false };
    }
    async Wo_GetHashtag(ctx, tag) {
        // tag = tag.substr(1)
        let md5_tag = md5(tag);
        let result;
        let create = false;
        if (typeof (+tag) === "number" && !isNaN((+tag))) {
            result = await ctx.wo_hashtags.findOne({
                where: {
                    id: tag
                }
            })
        } else {
            result = await ctx.wo_hashtags.findOne({
                where: {
                    hash: md5_tag
                }
            })
            create = true;
        }
        if (result) {
            return result;
        } else if (!result) {
            if (create) {
                let hash = md5(tag);
                let res = await ctx.wo_hashtags.create({
                    hash: hash,
                    tag: tag,
                    last_trend_time: Math.floor(Date.now() / 1000),
                    expire: moment().add(1, 'w').format("YYYY-MM-DD")
                })
                return res;
            }
        }
    }
    escapeRegExp(str) {
        let arr = str.match(/[.*+?^{}()|[\]\\]/g)
        if (arr && arr.length) {
            for (let a of arr) {
                str = str.replace(/[.*+?^{}()|[\]\\]/g, '\\' + a)
            }
        }
        return str
    }
    Wo_Emo(str) {
        let emo = {
            ':)': 'smile',
            '(<': 'joy',
            '**)': 'relaxed',
            ':p': 'stuck-out-tongue-winking-eye',
            ':_p': 'stuck-out-tongue',
            'B)': 'sunglasses',
            ';)': 'wink',
            ':D': 'grin',
            '/_)': 'smirk',
            '0)': 'innocent',
            ':_(': 'cry',
            ':__(': 'sob',
            ':(': 'disappointed',
            ':*': 'kissing-heart',
            '<3': 'heart',
            '</3': 'broken-heart',
            '*_*': 'heart-eyes',
            '<5': 'star',
            ':o': 'open-mouth',
            ':0': 'scream',
            'o(': 'anguished',
            '-_(': 'unamused',
            'x(': 'angry',
            'X(': 'rage',
            '-_-': 'expressionless',
            ':-/': 'confused',
            ':|': 'neutral-face',
            '!_': 'exclamation',
            ':|': 'neutral-face',
            ':|': 'neutral-face',
            ':yum:': 'yum',
            ':triumph:': 'triumph',
            ':imp:': 'imp',
            ':hear_no_evil:': 'hear-no-evil',
            ':alien:': 'alien',
            ':yellow_heart:': 'yellow-heart',
            ':sleeping:': 'sleeping',
            ':mask:': 'mask',
            ':no_mouth:': 'no-mouth',
            ':weary:': 'weary',
            ':dizzy_face:': 'dizzy-face',
            ':man:': 'man',
            ':woman:': 'woman',
            ':boy:': 'boy',
            ':girl:': 'girl',
            ':оlder_man:': 'older-man',
            ':оlder_woman:': 'older-woman',
            ':cop:': 'cop',
            ':dancers:': 'dancers',
            ':speak_no_evil:': 'speak-no-evil',
            ':lips:': 'lips',
            ':see_no_evil:': 'see-no-evil',
            ':dog:': 'dog',
            ':bear:': 'bear',
            ':rose:': 'rose',
            ':gift_heart:': 'gift-heart',
            ':ghost:': 'ghost',
            ':bell:': 'bell',
            ':video_game:': 'video-game',
            ':soccer:': 'soccer',
            ':books:': 'books',
            ':moneybag:': 'moneybag',
            ':mortar_board:': 'mortar-board',
            ':hand:': 'hand',
            ':tiger:': 'tiger',
            ':elephant:': 'elephant',
            ':scream_cat:': 'scream-cat',
            ':monkey:': 'monkey',
            ':bird:': 'bird',
            ':snowflake:': 'snowflake',
            ':sunny:': 'sunny',
            ':оcean:': 'ocean',
            ':umbrella:': 'umbrella',
            ':hibiscus:': 'hibiscus',
            ':tulip:': 'tulip',
            ':computer:': 'computer',
            ':bomb:': 'bomb',
            ':gem:': 'gem',
            ':ring:': 'ring'
        }
        let hasHTML = false;
        if (str) {
            //replace all using regex
            str = str.replace('&lt;', '<');
            str = str.replace('&gt;', '>');
            for (let code of Object.keys(emo).reverse()) {
                let searchRegExp = new RegExp(this.escapeRegExp(code), "gi");

                if (!hasHTML) {
                    let check = str.match(searchRegExp)
                    if (check) {
                        hasHTML = true;
                    } else {
                        continue
                    }
                }
                str = str.replace(searchRegExp, '<i class="twa-lg twa twa-' + emo[code] + '"></i>');
            }
        }
        return { msg: str, hasHTML }
    }
    Wo_Time_Elapsed_String(ctx, ptime) {
        let etime = Math.floor(Date.now() / 1000) - ptime;
        if (etime < 1) {
            //return '0 seconds';
            return 'Now';
        }
        // let a = {}
        // a["" + (365 * 24 * 60 * 60)] = ctx.globallangs['year']
        // a["" + (30 * 24 * 60 * 60)] = ctx.globallangs['month']
        // a["" + (24 * 60 * 60)] = ctx.globallangs['day']
        // a["" + (60 * 60)] = ctx.globallangs['hour']
        // a["" + (60)] = ctx.globallangs['minute']
        // a["" + (1)] = ctx.globallangs['second']
        // let a_plural = {}
        // a_plural[ctx.globallangs['year']] = 'years'
        // a_plural[ctx.globallangs['month']] = 'months'
        // a_plural[ctx.globallangs['day']] = 'days'
        // a_plural[ctx.globallangs['hour']] = 'hours'
        // a_plural[ctx.globallangs['minute']] = 'minutes'
        // a_plural[ctx.globallangs['second']] = 'seconds'
        var seconds = Math.abs(etime);
        var minutes = seconds / 60;
        var hours = minutes / 60;
        var days = hours / 24;
        var weeks = days / 7;
        var years = days / 365;
        function substitute(stringOrFunction, number) {
            var string = stringOrFunction;
            return number+' '+string;
        }
        // var words = seconds < 45 && substitute(ctx.globallangs['now'], '') ||
        // seconds < 90 && substitute('m', 1) ||
        // minutes < 45 && substitute('m', Math.round(minutes)) ||
        // minutes < 90 && substitute('h', 1) ||
        // hours < 24 && substitute('hrs', Math.round(hours)) ||
        // hours < 42 && substitute('d', 1) ||
        // days < 7 && substitute('d', Math.round(days)) ||
        // weeks < 2 && substitute('w', 1) ||
        // weeks < 52 && substitute('w', Math.round(weeks)) ||
        // years < 1.5 && substitute('y', 1) ||
        // substitute('yrs', Math.round(years));
        var words = '';
        if (seconds < 45) {
            words = substitute(ctx.globallangs['now'], '');
        }
        else if (seconds < 90) {
            words = substitute('m', 1);
        }
        else if (minutes < 45) {
            words = substitute('m', Math.round(minutes));
        }
        else if (minutes < 90) {
            words = substitute('h', 1);
        }
        else if (hours < 24) {
            words = substitute('hrs', Math.round(hours));
        }
        else if (hours < 42) {
            words = substitute('d', 1);
        }
        else if (days < 7) {
            words = substitute('d', Math.round(days));
        }
        else if (weeks < 2) {
            words = substitute('w', 1);
        }
        else if (weeks < 52) {
            words = substitute('w', Math.round(weeks));
        }
        else if (years < 1.5) {
            words = substitute('y', 1);
        }
        else {
            words = substitute('yrs', Math.round(years));
        }
        return words;



        // let a = {}
        // a["" + (365 * 24 * 60 * 60)] = 'y'
        // a["" + (30 * 24 * 60 * 60)] = 'w'
        // a["" + (24 * 60 * 60 * 7)] = 'w'
        // a["" + (24 * 60 * 60)] = 'd'
        // a["" + (60 * 60)] = 'h'
        // a["" + (60)] = 'm'
        // a["" + (1)] = 'now'
        // let a_plural = {}
        // a_plural['y'] = 'y'
        // a_plural['w'] = 'w'
        // a_plural['d'] = 'd'
        // a_plural['h'] = 'h'
        // a_plural['m'] = 'm'
        // a_plural[ctx.globallangs['now']] = 'now'
        // for (let secs of Object.keys(a).reverse()) {
        //     let d = etime / (+secs)
        //     if (d >= 1) {
        //         let r = Math.round(d)
        //         //return r + ' ' + (r > 1 ? a_plural[a[secs]] : a[secs]) + ' ' + ctx.globallangs['time_ago'];
        //         if (secs > 1) {
        //             return r + ' ' + (r > 1 ? a_plural[a[secs]] : a[secs]);
        //         }
        //         else{
        //             return ctx.globallangs['now'];
        //         }
                
        //     }
        // }
    }

    // placement should be 'chat' and 'message' for private and private_page respectively
    async Wo_DisplaySharedFile(ctx, message_id, placement, isSticker) {
        let message = await ctx.wo_messages.findOne({
            where: {
                id: message_id
            }
        })
        let orginal = message['media'];
        let is_video = false;
        // if (!is_video) {
        //   wo['media']['filename'] = Wo_GetMedia(message['filename']);
        // }

        let video_thumb = message['postFileThumb'] && message['postFileThumb'] != "" ? await Wo_GetMedia(message['postFileThumb']) : '';
        let media_name = message['mediaFileName'];
        if (isSticker || message['stickers'] != '') {
            if (message['stickers'] != '') {
                return '<img src="' + message['stickers'] + '" alt="GIF"></img>'
            }
            // media_name = message['stickers'];
            return '<img src="' + await this.Wo_GetMedia(ctx, message.media) + '" alt="GIF"></img>'
        }
        // if (message.media.includes("sticker")) {
        //     return '<img src="' + await this.Wo_GetMedia(ctx, message.media) + '" alt="GIF"></img>'
        // }
        let message_type = message['type'];
        let media_storyId = message['id'];
        // let is_video_ad = '';
        // let wo_ad_media = '';
        // let wo_ad_url = '';
        // let wo_ad_id = 0;
        // let rvad_con = '';

        let filename = await this.Wo_GetMedia(ctx, message.media)

        let icon_size = 'fa-2x';
        if (placement == 'chat') {
            icon_size = '';
        }
        if (filename) {
            let file_extension = path.extname(filename)
            let file = '';
            let media_file = '';
            let start_link = "<a href=" + filename + ">";
            let end_link = '</a>';
            file_extension = file_extension.toLowerCase()
            // if (cache != "") {
            //   filename = message.mediaFileName + "?cache=" + cache;
            // }


            if (file_extension == '.jpg' || file_extension == '.jpeg' || file_extension == '.png' || file_extension == '.gif') {
                if (placement == 'api') {
                    media_file += "<img src='" + filename + "' alt='image' class='image-file pointer' onclick=\"InjectAPI('{&quot;type&quot; : &quot;lightbox&quot;, &quot;image_url&quot;:&quot;" + filename + "&quot;}');\">";
                } else {
                    if (placement != 'chat' && placement != 'message') {
                        //   if (!empty(wo['story']) && wo['story']['blur'] == 1) {
                        //     media_file += "<button class='btn btn-main image_blur_btn remover_blur_btn_" + media_storyId + "' onclick='Wo_RemoveBlur(this," + media_storyId + ")'>" + wo['lang']['view_image'] + "</button>\
                        //               <img src='" + filename + "' alt='image' class='image-file pointer image_blur remover_blur_" + media_storyId + "' onclick='Wo_OpenLightBox(" + media_storyId + ");'>";
                        //   }
                        //   else {
                        //     media_file += "<img src='" + filename + "' alt='image' class='image-file pointer' onclick='Wo_OpenLightBox(" + media['storyId'] + ");'>";
                        //   }
                    } else {
                        media_file += "<span data-href='" + filename + "'  onclick='Wo_OpenLighteBox(this,event);'><img src='" + filename + "' alt='image' class='image-file pointer'></span>";
                    }
                }
            }
            if (file_extension == '.pdf') {
                file += '<i class="fa ' + icon_size + ' fa-file-pdf-o"></i> ' + media_name;
            }
            if (file_extension == '.txt') {
                file += '<i class="fa ' + icon_size + ' fa-file-text-o"></i> ' + media_name;
            }
            if (file_extension == '.zip' || file_extension == '.rar' || file_extension == '.tar') {
                file += '<i class="fa ' + icon_size + ' fa-file-archive-o"></i> ' + media_name;
            }
            if (file_extension == '.doc' || file_extension == '.docx') {
                file += '<i class="fa ' + icon_size + ' fa-file-word-o"></i> ' + media_name;
            }
            if (file_extension == '.mp3' || file_extension == '.wav') {
                if (placement == 'chat') {
                    file += '<i class="fa ' + icon_size + ' fa-music"></i> ' + media_name;
                }
                else if (placement == 'message') {
                    media_file += getChatAudioTemplate(filename);
                } else if (placement == 'record') {
                    media_file += getAudioTemplate(filename);
                } else {
                    media_file += getAudioTemplate(filename);
                }
            }
            if (file && file == "") {
                file += '<i class="fa ' + icon_size + ' fa-file-o"></i> ' + media_name;
            }
            if (file_extension == '.mp4' || file_extension == '.mkv' || file_extension == '.avi' || file_extension == '.webm' || file_extension == '.mov' || file_extension == '.m3u8' || is_video) {
                if (placement == 'message' || placement == 'chat') {
                    media_file += getChatVideoTemplate(filename);
                }
                // else {
                // if (file_extension == 'm3u8') {
                //     wo['media']['filename'] = config['s3_site_url_2'] + '/' + orginal;
                //     media_file += Wo_LoadPage('players/videojs');
                //   }
                //   else {
                //     media_file += Wo_LoadPage('players/video');
                //   }
                // }
            }
            let last_file_view = '';
            if (media_file && media_file != "") {
                last_file_view = media_file;
            } else {
                last_file_view = start_link + file + end_link;
            }
            return last_file_view;
        }

    }


    async Wo_UserData(ctx, user_id) {
        if (user_id === 0) {
            //group
            return
        }
        let user = await ctx.wo_users.findOne({
            where: {
                user_id: user_id
            }
        })
        if (user && user.first_name) {
            user.name = user.first_name
            if (user.last_name) {
                user.name += " " + user.last_name
            }
        }
        else {
            user.name = user.username
        }
        return user;
    }

    async Wo_GetMedia(ctx, media) {
        if (ctx.globalconfig['amazone_s3'] == 1) {
            return ctx.globalconfig['s3_site_url'] + '/' + media;
        } else if(ctx.globalconfig['wasabi_storage'] == 1){
            return ctx.globalconfig['wasabi_site_url'] + '/' + media;
        } else if (ctx.globalconfig['spaces'] == 1) {
            return 'https://' + ctx.globalconfig['space_name'] + '.' + ctx.globalconfig['space_region'] + '.digitaloceanspaces.com/' + media;
        } else if (ctx.globalconfig['ftp_upload'] == 1) {
            return 'https://' + ctx.globalconfig['ftp_endpoint'] + '/' + media;
        } else if (ctx.globalconfig['cloud_upload'] == 1) {
            return 'https://storage.googleapis.com/' + ctx.globalconfig['cloud_bucket_name'] + '/' + media;
        }
        return ctx.globalconfig['site_url'] + '/' + media;
    }

    async Wo_IsFollowing(ctx, following_id, user_id) {
        let result = await ctx.wo_followers.count({
            where: {
                following_id: following_id,
                follower_id: user_id,
                active: 1
            }
        })
        return result > 0 ? true : false;
    }

    // Register typing when typing event received
    async Wo_RegisterTyping(ctx, user_id, recipient_id, isTyping) {
        if (!await Wo_IsFollowing(userHashUserId[user_id], recipient_id)) {
            return false;
        }
        await wo_followers.update(
            {
                is_typing: isTyping,
            }, {
            where: {
                following_id: userHashUserId[user_id],
                follower_id: recipient_id
            }
        })
        return true;
    }
    // Emit to follower on chat tab open
    async Wo_IsTyping(ctx, user_id, recipient_id) {
        let follower_is_typing = await ctx.wo_followers.count({
            where: {
                follower_id: user_id,
                following_id: recipient_id,
                is_typing: 1
            }
        })
        return follower_is_typing > 0 ? true : false
    }

    //update this whenever a person joins or leaves with help of follower table
    // Type can be online / offline
    async Wo_GetChatUsers(ctx, user_id, type) {
        if (!user_id) {
            return []
        }
        let time = Math.floor(Date.now() / 1000) - 3;
        let blocked = await ctx.wo_blocks.findAll({
            attributes: [
                "blocked"
            ],
            where: {
                blocker: user_id
            },
            raw: true
        })
        let blocker = await ctx.wo_blocks.findAll({
            attributes: [
                "blocker"
            ],
            where: {
                blocked: user_id
            },
            raw: true
        })
        let followers = await ctx.wo_followers.findAll({
            attributes: ["following_id"],
            where: {
                follower_id: user_id,
                following_id: {
                    [Op.not]: user_id
                }
            },
            raw: true
        })
        let users;
        if (type == 'online') {
            users = await ctx.wo_users.findAll({
                attributes: [
                    "user_id", "first_name", "last_name", "avatar", "showlastseen", "username"
                ],
                where: {
                    user_id: {
                        [Op.in]: followers.map(f => f.following_id),
                        [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
                    },
                    active: '1',
                    lastseen: {
                        [Op.gt]: time
                    }
                },
                order: [
                    ['lastseen', 'DESC']
                ],
                raw: true
            })
        } else if (type == 'offline') {
            users = await ctx.wo_users.findAll({
                attributes: [
                    "user_id", "first_name", "last_name", "avatar", "showlastseen", "username"
                ],
                where: {
                    user_id: {
                        [Op.in]: followers.map(f => f.following_id),
                        [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
                    },
                    active: '1',
                    lastseen: {
                        [Op.lt]: time
                    }
                },
                order: [
                    ['lastseen', 'DESC']
                ],
                limit: 6,
                raw: true
            })
        }
        return users;
    }

    async getAllGroupsForUser(ctx, userId) {
        let groupIds = await ctx.wo_groupchatusers.findAll({
            attributes: ["group_id"],
            where: {
                user_id: userId
            }
        })
        return groupIds
    }

    async getGroupUsers(ctx, group_id) {
        let userIds = await ctx.wo_groupchatusers.findAll({
            attributes: ["user_id","last_seen"],
            where: {
                group_id: group_id
            }
        })
        return userIds
    }

    // When chat tab is opened update this
    async Wo_LastSeen(ctx, userid) {
        await ctx.wo_users.update({
            lastseen: Math.floor(Date.now() / 1000)
        }, {
            where: {
                user_id: userid,
                active: '1'
            }
        })
    }

    async Wo_GetMessagesUsers(ctx, user_id) {
        if (!user_id) {
            console.log("user_id was undefined")
            return
        }
        let blocked = await ctx.wo_blocks.findAll({
            attributes: [
                "blocked"
            ],
            where: {
                blocker: user_id
            },
            raw: true
        })
        let blocker = await ctx.wo_blocks.findAll({
            attributes: [
                "blocker"
            ],
            where: {
                blocked: user_id
            },
            raw: true
        })

        let usersChat = await ctx.wo_userschat.findAll({
            where: {
                conversation_user_id: {
                    [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
                },
                user_id: user_id
            },
            order: [
                ['time', 'DESC']
            ],
            limit: 50,
            raw: true
        })

        return usersChat;
    }


    async Wo_GetMessagesGroups(ctx, user_id) {
        let usersChat = await ctx.wo_groupchatusers.findAll({
            where: {
                user_id: user_id
            },
            limit: 50,
            raw: true
        })

        return usersChat;
    }


    async Wo_GetGroupChat(ctx, group_id) {
        let groupChat = await ctx.wo_groupchat.findOne({
            where: {
                group_id: group_id
            },
            raw: true
        })

        return groupChat;
    }

    async getLatestMessage(ctx, from_id, to_id) {
        let messageText = await ctx.wo_messages.findOne({
            where: {
                [Op.or]: [{
                        from_id: from_id,
                        to_id: to_id,
                        group_id: 0,
                        page_id: 0
                    },
                    {
                    from_id: to_id,
                    to_id: from_id,
                    group_id: 0,
                    page_id: 0
                }]
            },
            order: [
                ['id', 'DESC']
            ],
            limit: 1
        })
        return messageText
    }

    async getLatestGroupMessage(ctx, from_id, group_id) {
        let messageText = await ctx.wo_messages.findOne({
            where: {
                [Op.or]: [{
                    group_id: group_id
                }]
            },
            order: [
                ['id', 'DESC']
            ],
            limit: 1
        })
        return messageText
    }

    Wo_RightToLeft(ctx, type) {
        if (type === 'pull-right') {
            return 'pull-left';
        }
        if (type === 'pull-left') {
            return 'pull-right';
        }
        if (type === 'left-addon') {
            return 'right-addon';
        }
        if (type === 'text-right') {
            return 'text-left';
        }
        if (type === 'text-left') {
            return 'text-right';
        }
        if (type === 'right') {
            return 'left';
        }
        return type;
    }

    async Wo_IsOnline(ctx, userId) {
        let user = await ctx.wo_users.count({
            attributes: ["lastseen"],
            where: {
                userid: userId,
                lastseen: {
                    [Op.lt]: Math.floor(Date.now() / 1000)
                }
            }
        })

        return user > 0 ? true : false;
    }

    // Update Data
    async Wo_CountNotifications(ctx, userId) {
        let result = await ctx.wo_notification.count({
            where: {
                recipient_id: userId,
                seen: 0
            }
        })
        return result
    }

    async Wo_GetNotifications(ctx, userId) {
        let timepopunder = Math.floor(Date.now() / 1000);
        let result = await ctx.wo_notification.findAll({
            where: {
                recipient_id: userId,
                seen: 0,
                seen_pop: 0,
                time: timepopunder,
            },
            limit: 15,
            raw: true
        })

        await wo_notification.destroy({
            where: {
                time: {
                    [Op.lt]: (Math.floor(Date.now() / 1000) - (60 * 60 * 24 * 5))
                },
                seen: {
                    [Op.not]: 0
                }
            }
        })

        return result
    }

    async Wo_CountUnseenMessages(ctx, user_id) {
        let result = await ctx.wo_messages.count({
            where: {
                to_id: user_id,
                seen: 0
            }
        })
        return result
    }

    async Wo_CountMessages(ctx, user_id, from_id) {
        let blocked = await ctx.wo_blocks.findAll({
            attributes: [
                "blocked"
            ],
            where: {
                blocker: user_id
            },
            raw: true
        })
        let blocker = await ctx.wo_blocks.findAll({
            attributes: [
                "blocker"
            ],
            where: {
                blocked: user_id
            },
            raw: true
        })
        let result = await ctx.wo_messages.count({
            where: {
                [Op.or]: [{
                    from_id: {
                        [Op.eq]: from_id,
                        [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
                    },
                    to_id: user_id,
                }//,
                    // {
                    //     from_id: {
                    //         [Op.eq]: user_id,
                    //         [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
                    //     },
                    //     to_id: from_id,
                    // }
                ],
                seen: 0
            }
        })
        return result
    }

    async Wo_CheckLastGroupUnread(ctx, userId) {
        let result = await ctx.wo_groupchatusers.findAll({
            where: {
                id: userId,
                active: '1'
            },
            raw: true
        })
        let res = [];
        for (let r of res) {
            let last_message = await Wo_GetChatGroupLastMessage(res.group_id)
            if (last_message.time >= r.last_seen) {
                res.push(r)
            }
        }
        return res
    }

    async Wo_GetChatGroupLastMessage(ctx, group_id) {
        let result = await ctx.wo_messages.findAll({
            where: {
                group_id: group_id
            },
            order: [
                ['id', 'DESC']
            ],
            limit: 1,
            raw: true
        })
        return result
    }


    async Wo_CheckFroInCalls(ctx, id, type) {
        let result;
        if (type === "video") {
            result = await ctx.wo_videocalls.findAll({
                where: {
                    to_id: id,
                    time: {
                        [Op.gt]: Math.floor(Date.now() / 1000) - 40
                    },
                    active: '0',
                    declined: 0
                },
                raw: true
            })
        }
        else if (type === "audio") {
            result = await ctx.wo_audiocalls.findAll({
                where: {
                    to_id: id,
                    time: {
                        [Op.gt]: Math.floor(Date.now() / 1000) - 40
                    },
                    active: '0',
                    declined: 0
                },
                raw: true
            })
        }
        return result;
    }
    async Wo_GetMessageByID(ctx,id,data) {
        var message = await ctx.wo_messages.findOne({
                        where: {
                            id: id
                        }
                    });
        if (message && message !== undefined) {
            if (message.text != '') {
                var link_regex = new RegExp('(http\:\/\/|https\:\/\/|www\.)([^\ ]+)', 'gi');
                var mention_regex = new RegExp('@([A-Za-z0-9_]+)', 'gi');

                var linkSearch = message.text.match(link_regex)
                if (linkSearch && linkSearch.length > 0) {
                    hasHTML = true;
                    for (var linkSearchOne of linkSearch) {
                        var matchUrl = striptags(linkSearchOne)
                        var syntax = '[a]' + escape(matchUrl) + '[/a]'
                        message.text = message.text.replace(link_regex, syntax)
                    }
                }
                var mentionSearch = message.text.match(mention_regex)
                if (mentionSearch && mentionSearch.length > 0) {
                    hasHTML = true;
                    for (var mentionSearchOne of mentionSearch) {
                        var mention = await ctx.wo_users.findOne({
                            where: {
                                username: mentionSearchOne.substr(1, mentionSearchOne.length)
                            }
                        })
                        if (mention) {
                            var match_replace = '@[' + mention['user_id'] + ']';
                            message.text = message.text.replace(mention_regex, match_replace)
                        }
                    }
                }

                var hashTagSearch = message.text.match(/#([^`~!@$%^&*\#()\-+=\\|\/\.,<>?\'\":;{}\[\]* ]+)/gi)
                if (hashTagSearch && hashTagSearch.length > 0) {
                    hasHTML = true
                    for (var hashTagSearchOne of hashTagSearch) {
                        var hashdata = await this.Wo_GetHashtag(ctx, hashTagSearchOne.substr(1))
                        var replaceString = '#[' + hashdata['id'] + ']';
                        message.text = message.text.replace(/#([^`~!@$%^&*\#()\-+=\\|\/\.,<>?\'\":;{}\[\]* ]+)/gi, replaceString)
                        
                    }
                }
                message.text = await this.Wo_Markup(ctx, message.text);
            }
        }
        return message;

    }
    async Wo_GetReactionsTypes(ctx,type = 'page') {
        let result = await ctx.wo_reactions_types.findAll({raw: true})
        let res = [];
        result.forEach(element => {
            element.name = ctx.globallangs[element.name];
            if (type == 'page') {
                // console.log(path.resolve('../themes/',ctx.globalconfig["theme"]+'/reaction/like-sm.png'))
                // if (fs.existsSync(path.resolve('../themes/',ctx.globalconfig["theme"]+'/reaction/like-sm.png'))) {
                //     console.log('dddddddddd')
                //     console.log(fs.existsSync('./themes/'))
                // }


                if (element.wowonder_icon && element.wowonder_icon != '' && element.wowonder_icon !== undefined) {
                    (async () => {
                    element.wowonder_icon = element.wowonder_small_icon = await this.Wo_GetMedia(ctx,element.wowonder_icon);
                    })();
                    element.is_html = 0;
                }
                else if (!fs.existsSync(path.resolve('../themes/',ctx.globalconfig["theme"]+'/reaction/like-sm.png'))) {
                    if (element.id == 1) {
                        element.wowonder_icon = '<div class="emoji emoji--like"><div class="emoji__hand"><div class="emoji__thumb"></div></div></div>';
                    }
                    if (element.id == 2) {
                        element.wowonder_icon = '<div class="emoji emoji--love"><div class="emoji__heart"></div></div>';
                    }
                    if (element.id == 3) {
                        element.wowonder_icon = '<div class="emoji emoji--haha"><div class="emoji__face"><div class="emoji__eyes"></div><div class="emoji__mouth"><div class="emoji__tongue"></div></div></div></div>';
                    }
                    if (element.id == 4) {
                        element.wowonder_icon = '<div class="emoji emoji--wow"><div class="emoji__face"><div class="emoji__eyebrows"></div><div class="emoji__eyes"></div><div class="emoji__mouth"></div></div></div>';
                    }
                    if (element.id == 5) {
                        element.wowonder_icon = '<div class="emoji emoji--sad"><div class="emoji__face"><div class="emoji__eyebrows"></div><div class="emoji__eyes"></div><div class="emoji__mouth"></div></div></div>';
                    }
                    if (element.id == 6) {
                        element.wowonder_icon = '<div class="emoji emoji--angry"><div class="emoji__face"><div class="emoji__eyebrows"></div><div class="emoji__eyes"></div><div class="emoji__mouth"></div></div></div>';
                    }
                    element.wowonder_small_icon = '';
                    element.is_html = 1;
                }

                if (element.sunshine_icon && element.sunshine_icon != '' && element.sunshine_icon !== undefined) {
                    (async () => {
                    element.sunshine_icon = element.sunshine_small_icon = await this.Wo_GetMedia(ctx,element.sunshine_icon);
                })();
                }
                else if (fs.existsSync(path.resolve('../themes/',ctx.globalconfig["theme"]+'/reaction/like-sm.png'))) {
                    if (element.id == 1) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/like.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/like-sm.png";
                    }
                    if (element.id == 2) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/love.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/love-sm.png";
                    }
                    if (element.id == 3) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/haha.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/haha-sm.png";
                    }
                    if (element.id == 4) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/wow.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/wow-sm.png";
                    }
                    if (element.id == 5) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/sad.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/sad-sm.png";
                    }
                    if (element.id == 6) {
                        element.sunshine_icon = ctx.globalconfig['theme_url']+"/reaction/angry.gif";
                        element.sunshine_small_icon = ctx.globalconfig['theme_url']+"/reaction/angry-sm.png";
                    }
                }
            }
            res[element.id] = element;
        });
        return res;
    }
    async Wo_IsReacted(ctx,object_id, col = "post",type = '',user_id) {
        var name = col+'_id';
        if (type == 'blog') {
            var result = await ctx.wo_blog_reaction.count({
                where: {
                    [name]: object_id,
                    user_id: user_id
                },
                raw: true
            });
        }
        else{
            var result = await ctx.wo_reactions.count({
                where: {
                    [name]: object_id,
                    user_id: user_id
                },
                raw: true
            });
        }
        return result;
    }
    async Wo_GetPostReactionsTypes(ctx,object_id, col = "post",user_id,type = 'post') {
        var name = col+'_id';
        var reactions     = [];
       var reactions_count = 0;
       if (type == 'blog') {
            var result = await ctx.wo_blog_reaction.findAll({
                where: {
                    [name]: object_id
                },
                raw: true
            });
       }
       else{
            var result = await ctx.wo_reactions.findAll({
                where: {
                    [name]: object_id
                },
                raw: true
            });
       }
       result.forEach(element => {
            reactions[element.reaction] = 1;
            if (element.user_id == user_id) {
               reactions['is_reacted'] = true;
               reactions['type'] = element.reaction;
            }
            reactions_count++;

       });
       if (!reactions['is_reacted']) {
            reactions['is_reacted'] = false;
            reactions['type'] = '';
       }
       reactions['count'] = reactions_count;
       return reactions;

    }
    async Wo_GetPostReactions(ctx,object_id, col = "post",type = '') {
       var reactions_html = '';
       var reactions     = [];
       var reactions_count = 0;
       var name = col+'_id';
       if (type == 'blog') {
            var result = await ctx.wo_blog_reaction.findAll({
                where: {
                    [name]: object_id
                },
                raw: true
            });
       }
       else{
            var result = await ctx.wo_reactions.findAll({
                where: {
                    [name]: object_id
                },
                raw: true
            });
       }
       result.forEach(element => {
            reactions[element.reaction] = element.reaction;
            reactions_count++;

       });


       
           

       if(reactions && reactions !== undefined){

            reactions.forEach(element => {
                if (type == 'blog' || col == 'message') {
                    var first = "<span class=\"how_reacted like-btn-"+element.toLowerCase()+"\" id=\"_"+col+object_id+"\">";
                }
                else{
                    var first = "<span class=\"how_reacted like-btn-"+element.toLowerCase()+"\" id=\"_"+col+object_id+"\" onclick=\"Wo_OpenPostReactedUsers("+object_id+",'"+element.toLowerCase()+"','"+col+"');\">";
                }

                if (ctx.reactions_types[element].is_html == 1) {


                    if (ctx.reactions_types[element].is_html == 1) {


                        switch (parseInt(element)) {
                           case 1:
                               reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--like'><div class='emoji__hand'><div class='emoji__thumb'></div></div></div></div></span>";
                               break;
                           case 2:
                               reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--love'><div class='emoji__heart'></div></div></div></span>";
                               break;
                           case 3:
                              reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--haha'><div class='emoji__face'><div class='emoji__eyes'></div><div class='emoji__mouth'><div class='emoji__tongue'></div></div></div></div></div></span>";
                               break;
                           case 4:
                               reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--wow'><div class='emoji__face'><div class='emoji__eyebrows'></div><div class='emoji__eyes'></div><div class='emoji__mouth'></div></div></div></div></span>";
                               break;
                           case 5:
                               reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--sad'><div class='emoji__face'><div class='emoji__eyebrows'></div><div class='emoji__eyes'></div><div class='emoji__mouth'></div></div></div></div></span>";
                               break;
                           case 6:
                               reactions_html += first+"<div class='inline_post_count_emoji no_anim'><div class='emoji emoji--angry'><div class='emoji__face'><div class='emoji__eyebrows'></div><div class='emoji__eyes'></div><div class='emoji__mouth'></div></div></div></div></span>";
                               break;
                       }
                    }
                    else{
                        if (ctx.reactions_types[element].wowonder_small_icon && ctx.reactions_types[element].wowonder_small_icon !== undefined && ctx.reactions_types[element].wowonder_small_icon != '') {
                            reactions_html += first+"<div class='inline_post_count_emoji reaction'><img src='"+ctx.reactions_types[element].wowonder_small_icon+"' alt=\""+ctx.reactions_types[element].name+"\"></div></span>";
                        }
                    }
                }
                else{

                    if (ctx.reactions_types[element].sunshine_small_icon && ctx.reactions_types[element].sunshine_small_icon !== undefined && ctx.reactions_types[element].sunshine_small_icon != '') {
                        reactions_html += first+"<div class='inline_post_count_emoji'><img src='"+ctx.reactions_types[element].sunshine_small_icon+"' alt=\""+ctx.reactions_types[element].name+"\"></div></span>";
                    }
                }

            });

            if (reactions_count == 0) {
                reactions_count = '';
            }
            if (col != 'message') {
                return reactions_html += "<span class=\"how_many_reacts\">"+reactions_count+"</span>";
            }
            else{
                return reactions_html;
            }
       }else{
           return "";
       }
    }
    async FormatBytes(bytes, decimals = 2) {
        if (bytes === 0) return '0 Bytes';

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }
}

module.exports = new FunctionsUtils()

//   Wo_CountOnlineUsers // ()  {
  //   let blocked = await ctx.wo_blocks.findAll({
  //     attributes: [
  //       "blocked"
  //     ],
  //     where: {
  //       blocker: user_id
  //     },
  //     raw: true
  //   })
  //   let blocker = await ctx.wo_blocks.findAll({
  //     attributes: [
  //       "blocker"
  //     ],
  //     where: {
  //       blocked: user_id
  //     },
  //     raw: true
  //   })
  //   let followers = await ctx.wo_followers.findAll({
  //     attributes: ["following_id"],
  //     where: {
  //       follower_id: user_id,
  //       following_id: {
  //         [Op.not]: user_id
  //       }
  //     },
  //     raw: true
  //   })
  //   let online_user_count = await ctx.wo_users.count({
  //     where: {
  //       attributes: [
  //         "user_id"
  //       ],
  //       where: {
  //         user_id: {
  //           [Op.in]: followers.map(f => f.following_id),
  //           [Op.notIn]: blocked.map(b => b.blocked).concat(blocker.map(b => b.blocker))
  //         },
  //         active: '1',
  //         lastseen: {
  //           [Op.lt]: time
  //         }
  //       },
  //       order: [
  //         ['lastseen', 'DESC']
  //       ],
  //     }
  //   })
  //   return online_user_count;
  // }
