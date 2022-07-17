let Handlebars = require("handlebars")
let fs = require("fs")
const path = require('path');
let chatList ;
let groupList;
let offlineUser;
let onlineUser;
let messageList;
let messageGroupRecipientsList;
let messageRecipientsList;


// let notification = fs.readFileSync('./notification.html');

let chatListTemplate;
let groupListTemplate;
let messageListTemplate;
let offlineUserTemplate;
let onlineUserTemplate;
let messageGroupRecipientsTemplate;
let messageRecipientsTemplate;


const funcs = require('../functions/functions');
const { group } = require("console");
module.exports.DefineTemplates = async (ctx) => {
    chatList = fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/chat-list.phtml'));
    groupList =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/group-list.phtml'));
    offlineUser =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/offline-user.phtml'));
    onlineUser =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/online-user.phtml'));
    messageList =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/message-text-list.phtml'));
    messageGroupRecipientsList =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/messages-group-list.phtml'));
    messageRecipientsList =  fs.readFileSync(path.resolve(__dirname, '../../themes/'+ctx.globalconfig['theme']+'/layout/nodejs/messages-recipients-list.phtml'));

    chatListTemplate = Handlebars.compile(chatList.toString());
    groupListTemplate = Handlebars.compile(groupList.toString());
    messageListTemplate = Handlebars.compile(messageList.toString());
    offlineUserTemplate = Handlebars.compile(offlineUser.toString());
    onlineUserTemplate = Handlebars.compile(onlineUser.toString());
    messageGroupRecipientsTemplate = Handlebars.compile(messageGroupRecipientsList.toString());
    messageRecipientsTemplate = Handlebars.compile(messageRecipientsList.toString());
}
module.exports.messageRecipientsTemplate = async (ctx, recipientUserId, isActive, isOnline, count_messages, messageText) => {
    let user = await funcs.Wo_UserData(ctx, recipientUserId)
    if (user) {
        let a = messageRecipientsTemplate({
            active: isActive,
            recipientUserId: user.user_id,
            recipientName: user.name,
            recipientAvatar: await funcs.Wo_GetMedia(ctx, user.avatar),
            online: isOnline,
            message_count_is_zero: count_messages == 0,
            message_count: count_messages,
            elapased_time: (messageText.time ? funcs.Wo_Time_Elapsed_String(ctx, messageText.time) : ''),
            messageText: messageText.text || "",
        })
        return a
    } else {
        console.error("No user found undefined")
        return ""
    }
}


module.exports.messageGroupRecipientsTemplate = async (ctx, groupId, groupName, groupAvatar, isActive, messageText) => {
    let a = messageGroupRecipientsTemplate({
        active: isActive,
        pull_left_right: "pull_right",
        groupName: groupName,
        groupId: groupId,
        groupAvatar: await funcs.Wo_GetMedia(ctx, groupAvatar),
        time: (messageText.time ? funcs.Wo_Time_Elapsed_String(ctx, messageText.time) : ''),
        messageText: messageText.text || "",
    })
    return a
}

module.exports.onlineUserTemplate = async (ctx, onlineUser, count_messages) => {
    return onlineUserTemplate({
        chat_list_user_id: onlineUser.user_id,
        chat_list_name: (await funcs.Wo_UserData(ctx, onlineUser.user_id)).name,
        chat_list_avatar: await funcs.Wo_GetMedia(ctx, onlineUser.avatar),
        is_message_count_zero: count_messages == 0,
        message_count_per_user: count_messages,
    })
}

module.exports.offlineUserTemplate = async (ctx, offlineUser, count_messages) => {
    return offlineUserTemplate({
        chat_list_user_id: offlineUser.user_id,
        chat_list_name: (await funcs.Wo_UserData(ctx, offlineUser.user_id)).name,
        chat_list_avatar: await funcs.Wo_GetMedia(ctx, offlineUser.avatar),
        is_message_count_zero: ctx.globalconfig["user_lastseen"] === '1' && offlineUser.showlastseen !== '0',
        message_count_per_user: count_messages,
    })
}

module.exports.chatListOwnerFalse = async (ctx, data, fromUser, nextId, hasHTML, sendable_message) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    var chat_to_id = fromUser.user_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    reactions_html = "";
    onwer = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    
    return chatListTemplate({
        onwer: false,
        chatmsgId: "" + nextId,
        username: data.username,
        rightLeft: "",
        avatar: await funcs.Wo_GetMedia(ctx, fromUser.avatar),
        backgroundColor: "",
        color: "",
        media: false,
        chatTxt: sendable_message,
        hasHTML: hasHTML,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        have_reaction: have_reaction
    })
}

module.exports.chatListOwnerTrue = async (ctx, data, fromUser, nextId, hasHTML, sendable_message, color) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    var chat_to_id = data.to_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    reactions_html = "";
    onwer = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return chatListTemplate({
        onwer: true,
        chatmsgId: "" + nextId,
        username: data.username,
        rightLeft: "",
        avatar: "",
        hasHTML: hasHTML,
        media: false,
        backgroundColor: color,
        color: "rgb(255, 255, 255)",
        chatTxt: sendable_message,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        have_reaction: have_reaction
    })
}


module.exports.chatListOwnerTrueWithMedia = async (ctx, data, fromUser, nextId, hasHTML,  color, isSticker) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    var chat_to_id = data.to_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    reactions_html = "";
    onwer = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var file_size = "0MB";
    if (ctx.globalconfig['amazone_s3'] != 1 && ctx.globalconfig['wasabi_storage'] != 1 && ctx.globalconfig['spaces'] != 1 && ctx.globalconfig['ftp_upload'] != 1 && ctx.globalconfig['cloud_upload'] != 1) {
        var current_message = await funcs.Wo_GetMessageByID(ctx,data.mediaId);
        if (current_message && current_message != undefined && current_message.media && current_message.media != undefined) {
            s = fs.statSync(path.resolve(__dirname, '../../'+current_message.media));
            if (s && s != undefined && s.size && s.size != undefined) {
                file_size = await funcs.FormatBytes(s.size);
            }
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return chatListTemplate({
        onwer: true,
        chatmsgId: "" + nextId,
        username: data.username,
        rightLeft: "",
        avatar: "",
        media: true,
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'chat', isSticker),
        backgroundColor: color,
        color: "rgb(255, 255, 255)",
        chatTxt: "",
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        file_size: file_size,
        have_reaction: have_reaction
    })
}

module.exports.chatListOwnerFalseWithMedia = async (ctx, data, fromUser, nextId, hasHTML, isSticker) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    var chat_to_id = fromUser.user_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    reactions_html = "";
    onwer = false;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var file_size = "0MB";
    if (ctx.globalconfig['amazone_s3'] != 1 && ctx.globalconfig['wasabi_storage'] != 1 && ctx.globalconfig['spaces'] != 1 && ctx.globalconfig['ftp_upload'] != 1 && ctx.globalconfig['cloud_upload'] != 1) {
        var current_message = await funcs.Wo_GetMessageByID(ctx,data.mediaId);
        if (current_message && current_message != undefined && current_message.media && current_message.media != undefined) {
            s = fs.statSync(path.resolve(__dirname, '../../'+current_message.media));
            if (s && s != undefined && s.size && s.size != undefined) {
                file_size = await funcs.FormatBytes(s.size);
            }
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return chatListTemplate({
        onwer: false,
        chatmsgId: "" + nextId,
        username: data.username,
        rightLeft: "",
        avatar: await funcs.Wo_GetMedia(ctx, fromUser.avatar),
        backgroundColor: "",
        color: "",
        media: (data.media_data && data.media_link) || data.isSticker ? true : false,
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'chat', isSticker),
        chatTxt: data.msg,
        hasHTML: hasHTML,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        file_size: file_size,
        have_reaction: have_reaction
    })
}

module.exports.messageListOwnerTrue = async (ctx, data, fromUser, message, hasHTML, sendable_message, color) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    if (message && message.time && message.id && message.time != '' && message.id != '') {
        nextId = message.id;
        timeText = funcs.Wo_Time_Elapsed_String(ctx, message.time);
        time = message.time;
    }
    else{
        nextId = message;
        timeText = 'Just now';
        time = Math.floor(Date.now() / 1000);
    }
    reactions_html = "";
    onwer = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    if (!data.story) {
        data.story = {thumbnail: '',
                     id: 0,
                     title: ''};
    }
    var chat_to_id = data.to_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return messageListTemplate({
        onwer: true,
        chatMsgId: "" + nextId,
        username: data.username,
        avatar: await funcs.Wo_GetMedia(ctx, fromUser.avatar),
        hasHTML: hasHTML,
        backgroundColor: color,
        color: "rgb(255, 255, 255)",
        msgColor: "rgb(168, 72, 73)",
        chatTxt: sendable_message,
        msgTime: time,
        ElapsedTime: timeText,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        have_reaction: have_reaction
    })
}


module.exports.messageListOwnerTrueWithMedia = async (ctx, data, fromUser, message, hasHTML, color) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    if (message && message.time && message.id && message.time != '' && message.id != '') {
        nextId = message.id;
        timeText = funcs.Wo_Time_Elapsed_String(ctx, message.time);
        time = message.time;
    }
    else{
        nextId = message;
        timeText = 'Just now';
        time = Math.floor(Date.now() / 1000);
    }
    reactions_html = "";
    onwer = false;
    hasHTML = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var chat_to_id = data.to_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    var file_size = "0MB";
    if (ctx.globalconfig['amazone_s3'] != 1 && ctx.globalconfig['wasabi_storage'] != 1 && ctx.globalconfig['spaces'] != 1 && ctx.globalconfig['ftp_upload'] != 1 && ctx.globalconfig['cloud_upload'] != 1) {
        var current_message = await funcs.Wo_GetMessageByID(ctx,data.mediaId);
        if (current_message && current_message != undefined && current_message.media && current_message.media != undefined) {
            s = fs.statSync(path.resolve(__dirname, '../../'+current_message.media));
            if (s && s != undefined && s.size && s.size != undefined) {
                file_size = await funcs.FormatBytes(s.size);
            }
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return messageListTemplate({
        onwer: true,
        chatMsgId: "" + nextId,
        username: data.username,
        avatar: await funcs.Wo_GetMedia(ctx, fromUser.avatar),
        backgroundColor: color,
        hasHTML: hasHTML,
        color: "rgb(255, 255, 255)",
        chatTxt: "",
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'message'),
        msgTime: time,
        ElapsedTime: timeText,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        file_size: file_size,
        have_reaction: have_reaction
    })
}

module.exports.messageListOwnerFalse = async (ctx, data, message, fromUser, hasHTML, sendable_message) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    //funcs.Wo_Time_Elapsed_String(ctx, Math.floor(Date.now() / 1000))
    if (message && message.time && message.id && message.time != '' && message.id != '') {
        nextId = message.id;
        timeText = funcs.Wo_Time_Elapsed_String(ctx, message.time);
        time = message.time;
    }
    else{
        nextId = message;
        timeText = 'Just now';
        time = Math.floor(Date.now() / 1000);
    }
    reactions_html = "";
    onwer = false;
    hasHTML = true;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    if (!data.story) {
        data.story = {thumbnail: '',
                     id: 0,
                     title: ''};
    }
    var chat_to_id = fromUser.user_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }

    return messageListTemplate({
        onwer: false,
        chatMsgId: "" + nextId,
        username: data.username,
        avatar: await funcs.Wo_GetMedia(ctx, (fromUser.avatar) ? fromUser.avatar : 1),
        backgroundColor: "",
        color: "",
        chatTxt: sendable_message,
        hasHTML: hasHTML,
        msgTime: time,
        ElapsedTime: timeText,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        have_reaction: have_reaction
    })
}


module.exports.messageListOwnerFalseWithMedia = async (ctx, data, message, fromUser, isSticker) => {
    data.have_story = false;
    data.story = {thumbnail: '',
                 id: 0,
                 title: ''};
    if (data.story_id && data.story_id > 0) {
        var story = await ctx.wo_userstory.findOne({
                            where: {
                                id: data.story_id
                            }
                        })
        if (story && story.id) {
            data.have_story = true;
            if (story.thumbnail && story.thumbnail != '') {
                story.thumbnail = await funcs.Wo_GetMedia(ctx, story.thumbnail);
            }
            else{
                story.thumbnail = (await funcs.Wo_UserData(ctx, story.user_id)).avatar;
            }
        }
        data.story = story;
    }
    if (message && message.time && message.id && message.time != '' && message.id != '') {
        nextId = message.id;
        timeText = funcs.Wo_Time_Elapsed_String(ctx, message.time);
        time = message.time;
    }
    else{
        nextId = data.mediaId;
        if (message !== false) {
            nextId = message;
        }
        timeText = 'Just now';
        time = Math.floor(Date.now() / 1000);
    }
    reactions_html = "";
    onwer = false;
    ctx.reactions_types.forEach(element => {
        if (element.status == 1) {
            first_text = 'left: 10px;';
            if (onwer) {
                first_text = 'right: 10px;';
            }
            if (ctx.globalconfig['theme'] === "wowonder") {
                r_img = '<img src="'+element.wowonder_icon+'">';
                var matches = element.wowonder_icon.match(/<[^<]+>/);
                if (matches) {
                    r_img = element.wowonder_icon;
                }
                reactions_html += '<li style="'+first_text+'" class="reaction reaction-'+element.id+'" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.wowonder_small_icon+'\','+element.is_html+');">'+r_img+'</li>';

            }
            else{
                reactions_html += '<li style="'+first_text+'"class="reaction reaction-'+element.id+' animated_2" data-reaction="'+element.name+'" data-reaction-id="'+element.id+'" data-reaction-lang="'+element.name+'" data-post-id="'+nextId+'" onclick="Wo_RegisterMessageReaction(this,\''+element.sunshine_small_icon+'\');"><img class="" src="'+element.sunshine_icon+'" alt="'+element.name+'"></li>';
            }
        }
    });
    reactions_info_html = await funcs.Wo_GetPostReactions(ctx,nextId,'message');
    var chat_to_id = fromUser.user_id;
    var reply_message = {text: ''};
    var have_reply = false;
    var mediaReplyHTML = false;
    if (data.message_reply_id && data.message_reply_id !== undefined && data.message_reply_id > 0) {
        r_message = await funcs.Wo_GetMessageByID(ctx,data.message_reply_id);
        if (r_message && r_message != undefined) {
            have_reply = true;
            if (r_message.media && r_message.media != undefined) {
                mediaReplyHTML = await funcs.Wo_DisplaySharedFile(ctx, r_message.id, 'chat');
            }
            reply_message = r_message;
        }
    }
    var file_size = "0MB";
    if (ctx.globalconfig['amazone_s3'] != 1 && ctx.globalconfig['wasabi_storage'] != 1 && ctx.globalconfig['spaces'] != 1 && ctx.globalconfig['ftp_upload'] != 1 && ctx.globalconfig['cloud_upload'] != 1) {
        var current_message = await funcs.Wo_GetMessageByID(ctx,data.mediaId);
        if (current_message && current_message != undefined && current_message.media && current_message.media != undefined) {
            s = fs.statSync(path.resolve(__dirname, '../../'+current_message.media));
            if (s && s != undefined && s.size && s.size != undefined) {
                file_size = await funcs.FormatBytes(s.size);
            }
        }
    }
    var have_reaction = false;
    if (reactions_info_html != '') {
        have_reaction = true;
    }
    return messageListTemplate({
        onwer: false,
        chatMsgId: "" + nextId,
        username: data.username,
        avatar: await funcs.Wo_GetMedia(ctx, fromUser.avatar),
        backgroundColor: "",
        color: "",
        chatTxt: "",
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'message', isSticker),
        msgTime: time,
        ElapsedTime: timeText,
        reactions_html: reactions_html,
        reactions_info_html: reactions_info_html,
        have_story: data.have_story,
        story_thumbnail: data.story.thumbnail,
        story_title: data.story.title,
        story_id: data.story.id,
        chat_to_id: chat_to_id,
        have_reply: have_reply,
        reply_text: reply_message.text,
        mediaReplyHTML: mediaReplyHTML,
        file_size: file_size,
        have_reaction: have_reaction
    })
}




module.exports.groupListOwnerTrue = async (ctx, messageOwner, nextId, data, hasHTML, sendable_message) => {
    return groupListTemplate({
        onwer: true,
        chatmsgId: "" + nextId,
        chatMsgTxt: sendable_message,
        hasHTML: hasHTML,
        username: messageOwner.username,
    })
}


module.exports.groupListOwnerTrueWithMedia = async (ctx, messageOwner, nextId, data, sendable_message, isSticker) => {
    return groupListTemplate({
        onwer: true,
        chatmsgId: "" + nextId,
        chatMsgTxt: "",
        username: messageOwner.username,
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'chat', isSticker),
    })
}

module.exports.groupListOwnerFalse = async (ctx, messageOwner, nextId, data, hasHTML, sendable_message) => {
    return groupListTemplate({
        chatMsgId: "" + nextId,
        onwer: false,
        chatMsgTxt: sendable_message,
        hasHTML: hasHTML,
        username: messageOwner.username,
    })
}


module.exports.groupListOwnerFalseWithMedia = async (ctx, messageOwner, nextId, data, sendable_message, isSticker) => {
    return groupListTemplate({
        chatMsgId: "" + nextId,
        onwer: false,
        chatMsgTxt: "",
        mediaHTML: await funcs.Wo_DisplaySharedFile(ctx, data.mediaId, 'chat', isSticker),
        username: messageOwner.username,
    })
}