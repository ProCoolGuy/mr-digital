const funcs = require('../functions/functions')
const compiledTemplates = require('../compiledTemplates/compiledTemplates')
const moment = require("moment")


module.exports.emitUserStatus = async (ctx, io, user_id) => {
    let online_users = await funcs.Wo_GetChatUsers(ctx, user_id, "online");
    let offline_users = await funcs.Wo_GetChatUsers(ctx, user_id, "offline");
    let onlineUserSendHtml = '<div class="online-users">'
    for (let onlineUser of online_users) {
        //check if online_user is really online i.e. he has any socket connected at present
        if (!ctx.userIdCount[onlineUser.user_id] || ctx.userIdCount[onlineUser.user_id] <= 0) {
            // as user id has no stored connection passon to offline_user
            offline_users.push(onlineUser)
            continue;
        }
        let count_messages = await funcs.Wo_CountMessages(ctx, user_id, onlineUser.user_id)
        let onlineUserHtml = await compiledTemplates.onlineUserTemplate(ctx, onlineUser, count_messages)
        onlineUserSendHtml += onlineUserHtml
    }
    onlineUserSendHtml += '</div>'

    let offlineUserSendHtml = '<div class="offline-users">'
    for (let offlineUser of offline_users) {
        let count_messages = await funcs.Wo_CountMessages(ctx, user_id, offlineUser.user_id)

        let offlineuserHtml = await compiledTemplates.offlineUserTemplate(ctx, offlineUser, count_messages)
        offlineUserSendHtml += offlineuserHtml

    }
    offlineUserSendHtml += '</div>'

    await io.to(user_id).emit("user_status_change", {
        online_users: onlineUserSendHtml,
        offline_users: offlineUserSendHtml
    })
}

module.exports.updateMessageUsersList = async (ctx, io, user_id, to_whom) => {
    let messageUsers = await funcs.Wo_GetMessagesUsers(ctx, user_id);
    let html = ""
    if (!messageUsers) {
        console.log("Returning as no users")
        return
    }
    for (let user of messageUsers) {
        let count_messages = await funcs.Wo_CountMessages(ctx, user_id, user.conversation_user_id);
        let messageText = await funcs.getLatestMessage(ctx, user_id, user.conversation_user_id);
        if (!messageText || !messageText.text) {
            if (!messageText || messageText.media) {
                messageText = messageText ? messageText.text = "" : { text: "" }
            } else{
                messageText = { text: "" }
            }
            // else {
            //     console.log("Continuing as no message text found")
            //     continue
            // }
        }
        //let hasHTML = messate.text.split(" ").includes("<i");
        // let text = messageText.text;
        // ({ text: msg, hasHTML } = funcs.Wo_Emo(messageText.text))
        // messageText = text;
        let isOnline = ctx.userIdSocket[user.conversation_user_id] && ctx.userIdSocket[user.conversation_user_id].length > 0
        let isActive = ctx.userIdExtra[user_id] ? (ctx.userIdExtra[user_id].active_message_user_id === user.conversation_user_id) || (ctx.userIdExtra[user_id].active_message_user_id === +to_whom) : false  //(+to_whom === user.conversation_user_id) || (user_id === user.conversation_user_id);
        html += await compiledTemplates.messageRecipientsTemplate(ctx, user.conversation_user_id, isActive, isOnline, count_messages, messageText)
    }
    await io.to(user_id).emit("update-message-users-list", {
        status: 200,
        html: html
    })
}

module.exports.updateMessageGroupsList = async (ctx, io, user_id) => {
    if (!user_id) {
        console.log("No user")
        return
    }
    let groups = await funcs.Wo_GetMessagesGroups(ctx, user_id);
    let html = ""
    for (let g of groups) {
        // let count_messages = await funcs.Wo_CountMessages(ctx, user_id, user.conversation_user_id);
        let group = await funcs.Wo_GetGroupChat(ctx, g.group_id)
        let messageText = await funcs.getLatestGroupMessage(ctx, user_id, group.group_id);
        let isActive = ctx.userIdExtra[user_id] ? (ctx.userIdExtra[user_id].active_message_user_id === group.group_id) || (ctx.userIdExtra[user_id].active_message_user_id === +group.group_id) : false  //(+to_whom === user.conversation_user_id) || (user_id === user.conversation_user_id);
        if (!messageText) {
            messageText = { text: "" }
        }

        html += await compiledTemplates.messageGroupRecipientsTemplate(ctx, group.group_id, group.group_name, group.avatar, isActive, messageText)
    }
    await io.to(user_id).emit("update-group-side", {
        status: 200,
        html: html
    })
}


async function updateMessageGroupsListInternal(ctx, io, user_id, to_id, sendable_message, group_id) {
    if (!user_id) {
        console.log("No user")
        return
    }
    let groups = await funcs.Wo_GetMessagesGroups(ctx, to_id);
    let html = ""
    for (let g of groups) {
        // let count_messages = await funcs.Wo_CountMessages(ctx, user_id, user.conversation_user_id);
        let group = await funcs.Wo_GetGroupChat(ctx, g.group_id)
        if (sendable_message && +group_id === g.group_id) {
            messageText = { text: sendable_message }
        } else {
            messageText = await funcs.getLatestGroupMessage(ctx, user_id, group.group_id);
            if (!messageText) {
                messageText = await funcs.getLatestGroupMessage(ctx, to_id, group.group_id);
            }
        }
        let isActive = ctx.userIdExtra[to_id] ? (ctx.userIdExtra[to_id].active_message_to_id === group.group_id) || (ctx.userIdExtra[to_id].active_message_user_id === +group.group_id) : false  //(+to_whom === user.conversation_user_id) || (user_id === user.conversation_user_id);
        if (!messageText) {
            messageText = { text: "" }
        }

        html += await compiledTemplates.messageGroupRecipientsTemplate(ctx, group.group_id, group.group_name, group.avatar, isActive, messageText)
    }
    await io.to(to_id).emit("update-group-side", {
        status: 200,
        html: html
    })
}

module.exports.typing = async (ctx, io, senderAvatar, receiverId, senderId) => {
    await io.to(receiverId).emit("typing", {
        is_typing: 200,
        recipient_id: receiverId,
        sender_id: senderId,
        img: await funcs.Wo_GetMedia(ctx, senderAvatar),
        typing: ctx.globalconfig["theme_url"] + '/img/loading_dots.gif'
    })
}
module.exports.recording = async (ctx, io, senderAvatar, receiverId, senderId) => {
    await io.to(receiverId).emit("recording", {
        is_recording: 200,
        recipient_id: receiverId,
        sender_id: senderId,
        img: await funcs.Wo_GetMedia(ctx, senderAvatar),
        recording: ctx.globalconfig["theme_url"] + '/img/loading_dots.gif'
    })
}


module.exports.recordingDone = async (ctx, io, data, senderId) => {
    // Anything other than 200 will remove the dots
    await io.to(data.recipient_id).emit('recording', {
        recipient_id: data.recipient_id,
        sender_id: senderId,
        is_recording: 300
    })
}
module.exports.typingDone = async (ctx, io, data, senderId) => {
    // Anything other than 200 will remove the dots
    await io.to(data.recipient_id).emit('typing', {
        recipient_id: data.recipient_id,
        sender_id: senderId,
        is_typing: 300
    })
}

module.exports.lastseen = async (ctx, socket, message) => {
    let seenMsg = funcs.Wo_Time_Elapsed_String(ctx, message.seen)
    socket.emit("lastseen", {
        can_seen: 1,
        time: seenMsg,
        seen: seenMsg
    })
}

module.exports.unseen = async (ctx, socket) => {
    socket.emit("lastseen", {
        can_seen: 0,
    })
}

module.exports.privateMessageToPersonOwnerFalse = async (ctx, io, data, fromUser, nextId, hasHTML, sendable_message, color) => {
    var lng = 0;
    var lat = 0;
    if (data.lng && data.lat && data.lng !== undefined && data.lat !== undefined) {
        lng = data.lng;
        lat = data.lat;
    }
    io.to(data.to_id).emit('private_message', {
        messages_html: await compiledTemplates.chatListOwnerFalse(ctx, data, fromUser, nextId, hasHTML, sendable_message),
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        username: ((fromUser && fromUser.first_name !== undefined && fromUser.first_name != '' && fromUser.last_name !== undefined && fromUser.last_name != '') ? fromUser.first_name + ' ' + fromUser.last_name : fromUser.username),
        avatar: ((fromUser && fromUser.avatar !== undefined) ? await funcs.Wo_GetMedia(ctx, fromUser.avatar) : ''),
        sender: ctx.userHashUserId[data.from_id],
        color: color,
        message: data.msg,
        message_html: sendable_message,
        time: '<div class="messages-last-sent pull-right time ajax-time" title="' + moment().toISOString() + '">..</div>',
        isMedia: false,
        isRecord: false,
        lng: lng,
        lat: lat,
        message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
        time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
    });
}


module.exports.privateMessageToPersonOwnerTrue = async (ctx, io, data, fromUser, nextId) => {
    io.to(data.to_id).emit('private_message', {
        messages_html: await compiledTemplates.chatListOwnerTrue(ctx, data, fromUser, nextId),
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id]
    });
}


module.exports.privateMessageUsingPageToPersonOwnerTrue = async (ctx, io, data, fromUser, nextId, hasHTML, sendable_message, color) => {
    await io.to(data.to_id).emit('private_message_page', {
        html: await compiledTemplates.messageListOwnerTrue(ctx, data, fromUser, nextId, hasHTML, sendable_message, color),
        status: 200,
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id]
    });
}


module.exports.privateMessagePageToPersonOwnerTrueWithMedia = async (ctx, io, data, fromUser, isSticker) => {
    await io.to(data.to_id).emit('private_message_page', {
        html: await compiledTemplates.messageListOwnerTrueWithMedia(ctx, data, nextId, fromUser, isSticker),
        status: 200,
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id]
    });
}


module.exports.privateMessagePageToPersonOwnerFalseWithMedia = async (ctx, io, data, fromUser, nextId, hasHTML, isSticker) => {
    var lng = 0;
    var lat = 0;
    if (data.lng && data.lat && data.lng !== undefined && data.lat !== undefined) {
        lng = data.lng;
        lat = data.lat;
    }
    var message_img = await ctx.wo_messages.findOne({
        where: {
            id: data.mediaId
        }
    })
    await io.to(data.to_id).emit('private_message_page', {
        html: await compiledTemplates.messageListOwnerFalseWithMedia(ctx, data, nextId, fromUser, isSticker),
        status: 200,
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id],
        isMedia: true,
        time: '<div class="messages-last-sent pull-right time ajax-time" title="' + moment().toISOString() + '">..</div>',
        mediaLink: await funcs.Wo_GetMedia(ctx, message_img.media),
        isMedia: true,
        isRecord: true,
        lng: lng,
        lat: lat,
        message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : data.mediaId),
        time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : message_img.time),
    });
}

module.exports.privateMessageToPersonOwnerFalseWithMedia = async (ctx, io, data, fromUser, nextId, hasHTML, isSticker) => {
    var lng = 0;
    var lat = 0;
    if (data.lng && data.lat && data.lng !== undefined && data.lat !== undefined) {
        lng = data.lng;
        lat = data.lat;
    }
    var message_img = await ctx.wo_messages.findOne({
        where: {
            id: data.mediaId
        }
    })
    await io.to(data.to_id).emit('private_message', {
        messages_html: await compiledTemplates.chatListOwnerFalseWithMedia(ctx, data, fromUser, nextId, hasHTML, isSticker),
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id],
        username: ((fromUser && fromUser.first_name !== undefined && fromUser.first_name != '' && fromUser.last_name !== undefined && fromUser.last_name != '') ? fromUser.first_name + ' ' + fromUser.last_name : fromUser.username),
        avatar: ((fromUser && fromUser.avatar !== undefined) ? await funcs.Wo_GetMedia(ctx, fromUser.avatar) : ''),
        isMedia: true,
        time: '<div class="messages-last-sent pull-right time ajax-time" title="' + moment().toISOString() + '">..</div>',
        mediaLink: await funcs.Wo_GetMedia(ctx, message_img.media),
        isMedia: true,
        isRecord: true,
        lng: lng,
        lat: lat,
        message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : data.mediaId),
        time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : message_img.time),
    });
}

module.exports.privateMessagePageToPersonOwnerFalse = async (ctx, io, data, fromUser, nextId, hasHTML, sendable_message, color) => {
    var lng = 0;
    var lat = 0;
    if (data.lng && data.lat && data.lng !== undefined && data.lat !== undefined) {
        lng = data.lng;
        lat = data.lat;
    }
    io.to(data.to_id).emit('private_message_page', {
        html: await compiledTemplates.messageListOwnerFalse(ctx, data, nextId, fromUser, hasHTML, sendable_message),
        status: 200,
        id: ctx.userHashUserId[data.from_id],
        receiver: data.to_id,
        sender: ctx.userHashUserId[data.from_id],
        color: color,
        message: data.msg,
        message_html: sendable_message,
        time: '<div class="messages-last-sent pull-right time ajax-time" title="' + moment().toISOString() + '">..</div>',
        isMedia: false,
        isRecord: false,
        lng: lng,
        lat: lat,
        message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
        time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
    });
}

module.exports.groupMessage = async (ctx, io, socket, data, messageOwner, nextId, hasHTML, sendable_message) => {
    for (let client of Object.keys(io.sockets.adapter.rooms["group" + data.group_id].sockets)) {
        if (client === socket.id) {
            continue;
        }
        if (ctx.userIdSocket[messageOwner.user_id].filter(d => d.id === client).length) {
            await io.to(client).emit('group_message', {
                status: 200,
                html: await compiledTemplates.groupListOwnerTrue(ctx, messageOwner, nextId, data, hasHTML, sendable_message),
                id: data.group_id,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),

            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
        } else {
            await io.to(client).emit('group_message', {
                status: 200,
                html: await compiledTemplates.groupListOwnerFalse(ctx, messageOwner, nextId, data, hasHTML, sendable_message),
                id: data.group_id,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })

            if (ctx.socketIdUserHash[client] && ctx.userHashUserId[ctx.socketIdUserHash[client]]) {
                await updateMessageGroupsListInternal(ctx, io, ctx.userHashUserId[data.from_id], ctx.userHashUserId[ctx.socketIdUserHash[client]], sendable_message, data.group_id)
            }
        }
    }
}



module.exports.groupMessageWithMedia = async (ctx, io, socket, data, messageOwner, nextId, isSticker) => {
    for (let client of Object.keys(io.sockets.adapter.rooms["group" + data.group_id].sockets)) {
        if (client === socket.id) {
            continue;
        }
        if (ctx.userIdSocket[messageOwner.user_id].filter(d => d.id === client).length) {
            await io.to(client).emit('group_message', {
                status: 200,
                html: await compiledTemplates.groupListOwnerTrueWithMedia(ctx, messageOwner, nextId, data, isSticker),
                id: data.group_id,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
        } else {
            await io.to(client).emit('group_message', {
                status: 200,
                html: await compiledTemplates.groupListOwnerFalseWithMedia(ctx, messageOwner, nextId, data, isSticker),
                id: data.group_id,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
        }
    }
}



module.exports.groupMessagePage = async (ctx, io, socket, data, messageOwner, nextId, hasHTML, sendable_message) => {
    for (let client of Object.keys(io.sockets.adapter.rooms["group" + data.group_id].sockets)) {
        if (client === socket.id) {
            continue;
        }
        if (ctx.userIdSocket[messageOwner.user_id].filter(d => d.id === client).length) {
            await io.to(client).emit('group_message_page', {
                status: 200,
                html: await compiledTemplates.messageListOwnerTrue(ctx, data, messageOwner, nextId, hasHTML, sendable_message),
                id: data.group_id,
                receiver: ctx.userHashUserId[data.from_id],
                sender: ctx.userHashUserId[data.from_id],
                self: true,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
            await updateMessageGroupsListInternal(ctx, io, ctx.userHashUserId[data.from_id], ctx.userHashUserId[data.from_id], sendable_message, data.group_id)

        } else {
            await io.to(client).emit('group_message_page', {
                status: 200,
                html: await compiledTemplates.messageListOwnerFalse(ctx, data, nextId, messageOwner, hasHTML, sendable_message),
                id: data.group_id,
                receiver: data.group_id,
                sender: ctx.userHashUserId[data.from_id],
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
            if (ctx.socketIdUserHash[client] && ctx.userHashUserId[ctx.socketIdUserHash[client]]) {
                await updateMessageGroupsListInternal(ctx, io, ctx.userHashUserId[data.from_id], ctx.userHashUserId[ctx.socketIdUserHash[client]], sendable_message, data.group_id)
            }
        }
    }
}



module.exports.groupMessagePageWithMedia = async (ctx, io, socket, data, messageOwner, nextId, hasHTML, sendable_message, isSticker) => {
    for (let client of Object.keys(io.sockets.adapter.rooms["group" + data.group_id].sockets)) {
        if (client === socket.id) {
            continue;
        }
        if (ctx.userIdSocket[messageOwner.user_id].filter(d => d.id === client).length) {
            await io.to(client).emit('group_message_page', {
                status: 200,
                html: await compiledTemplates.messageListOwnerTrueWithMedia(ctx, data, nextId, messageOwner, isSticker),
                id: data.group_id,
                receiver: ctx.userHashUserId[data.from_id],
                sender: ctx.userHashUserId[data.from_id],
                self: true,
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
        } else {
            await io.to(client).emit('group_message_page', {
                status: 200,
                html: await compiledTemplates.messageListOwnerFalseWithMedia(ctx, data, nextId, messageOwner, hasHTML, isSticker),
                id: data.group_id,
                receiver: data.group_id,
                sender: ctx.userHashUserId[data.from_id],
                new_message: (data.new_message && data.new_message !== undefined ? data.new_message : ''),
                group_data: (data.group_data && data.group_data !== undefined ? data.group_data : ''),
                message_id: ((data.sent_message && data.sent_message !== undefined && data.sent_message.id && data.sent_message.id !== undefined ) ? data.sent_message.id : 0),
                time_api: ((data.sent_message && data.sent_message !== undefined && data.sent_message.time && data.sent_message.time !== undefined ) ? data.sent_message.time : 0),
            });
            await ctx.wo_groupchatusers.update({
                last_seen: Math.floor(Date.now() / 1000),
            },
                {
                    where: {
                        group_id: data.group_id,
                        user_id: ctx.userHashUserId[ctx.socketIdUserHash[client]]
                    }
                })
        }
    }
}
