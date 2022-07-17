<div class="modal fade" id="re-talking-modal" role="dialog" data-backdrop="static" data-keyboard="false">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title"><i class="fa fa fa-phone"></i> <?php echo $wo['lang']['audio_call'];?></h4>
         </div>
         <div class="modal-body">
            <div class="row">
              <div class="col-md-2" style="<?php echo ($wo['language_type'] == 'rtl') ? 'padding-left: 0; padding-right: 15px;' : 'padding-right:0; ';?>">
                <img src="<?php echo $wo['incall']['in_call_user']['avatar'];?>" alt="" class="hidden-mobile-image">
              </div>
              <div class="col-md-10">
                <p><?php echo $wo['lang']['audio_call_desc'];?><b> <?php echo $wo['incall']['in_call_user']['name'];?></b></p>
              </div>
              <div class="clear"></div>
              <div id="me"></div>
              <div id="remote-media">
                  <h3><i class="fa fa-spin fa-spinner"></i> <?php echo $wo['lang']['please_wait']?></h3>
              </div>
            </div>
         </div>
         <div class="modal-footer">
             <button type="button" class="btn decline-call btn-default" onclick="Wo_CloseCall('<?php echo $wo['incall']['id'];?>');"><i class="fa fa-times progress-icon" data-icon="times"></i> <?php echo $wo['lang']['cancel'];?></button>
         </div>
      </div>
   </div>
</div>
<?php if ($wo['config']['agora_chat_video'] == 1) { ?>
  <script type="text/javascript">
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
    if (!navigator.getUserMedia) {
      $('#remote-media h3').text('Sorry, WebRTC is not available in your browser.');
    }
    var agoraAppId = "<?php echo $wo['config']['agora_chat_app_id'];?>";
    var token = "<?php echo $wo['incall']['access_token'];?>";
    var channelName = "<?php echo $wo['incall']['room'];?>";
    var uid = <?php echo $wo['user']['id'];?>;

    // Handle errors.
    let handleError = function(err){
            console.log("Error: ", err);
    };
    // video profile settings
    var cameraVideoProfile = '480p_4'; // 640 × 480 @ 30fps  & 750kbs
    var screenVideoProfile = '480p_2'; // 640 × 480 @ 30fps
    // create client instances for camera (client) and screen share (screenClient)
    var client = AgoraRTC.createClient({mode: 'rtc', codec: 'vp8'}); 
    function initClientAndJoinChannel(agoraAppId, token, channelName, uid) {
      // init Agora SDK
      client.init(agoraAppId, function () {
        console.log("AgoraRTC client initialized");
        joinChannel(channelName, uid, token); // join channel upon successfull init
      }, function (err) {
        console.log("[ERROR] : AgoraRTC client init failed", err);
      });
    }
    // join a channel
    function joinChannel(channelName, uid, token) {
      client.join(token, channelName, uid, function(uid) {
          console.log("User " + uid + " join channel successfully");
          createCameraStream(uid);
          //localStreams.camera.id = uid; // keep track of the stream uid 
      }, function(err) {
          console.log("[ERROR] : join channel failed", err);
      });
    }

    // video streams for channel
    function createCameraStream(uid) {
      var localStream = AgoraRTC.createStream({
        streamID: uid,
        audio: true,
        video: false,
        screen: false
      });
      localStream.setVideoProfile(cameraVideoProfile);
      localStream.init(function() {
        console.log("getUserMedia successfully");
        // TODO: add check for other streams. play local stream full size if alone in channel
        localStream.play('me'); // play the given stream within the local-video div

        // publish local stream
        client.publish(localStream, function (err) {
          console.log("[ERROR] : publish local stream error: " + err);
        });
      
        //enableUiControls(localStream); // move after testing
        //localStreams.camera.stream = localStream; // keep track of the camera stream for later
      }, function (err) {
        console.log("[ERROR] : getUserMedia failed", err);
      });
    }
    client.on('stream-added', function (evt) {
      client.subscribe(evt.stream,  function (err) {
          console.log("[ERROR] : subscribe stream failed", err);
        });
    });

    client.on('stream-subscribed', function (evt) {
      var remoteStream = evt.stream;
      var remoteId = remoteStream.getId();
      $('#remote-media').empty();
      remoteStream.play('remote-media');
    });
    function leaveChannel() {

      client.leave(function() {
        // console.log("client leaves channel");
        // localStreams.camera.stream.stop() // stop the camera stream playback
        // client.unpublish(localStreams.camera.stream); // unpublish the camera stream
        // localStreams.camera.stream.close(); // clean up and close the camera stream
        $("#remote-media").empty() // clean up the remote feeds
        location.href = "<?php echo($wo['config']['site_url']) ?>";
      }, function(err) {
        console.log("client leave failed ", err); //error handling
      });
    }
    // remove the remote-container when a user leaves the channel
    client.on("peer-leave", function(evt) {

      location.href = "<?php echo($wo['config']['site_url']) ?>";
    });

    // use tokens for added security
    function generateToken() {
      return null; // TODO: add a token generation
    }
    $(document).on('click', '.decline-call', function(e) {
        leaveChannel(); 
        location.href = "<?php echo($wo['config']['site_url']) ?>";
    });
    
    initClientAndJoinChannel(agoraAppId, token, channelName, uid);
  </script>
<?php }else{ ?>
<script>

navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
if (!navigator.getUserMedia) {
  $('#remote-media h3').text('Sorry, WebRTC is not available in your browser.');
}


Twilio.Video.connect('<?php echo $wo['incall']['access_token'];?>', { name: '<?php echo $wo['incall']['room'];?>', audio: true, video: false }).then(room => {
  console.log('Connected to Room "%s"', room.name);
 
  room.participants.forEach(participantConnected);
  room.on('participantConnected', participantConnected);
  room.on('disconnected', room => {
    // Detach the local media elements
    room.localParticipant.tracks.forEach(publication => {
      const attachedElements = publication.track.detach();
      attachedElements.forEach(element => element.remove());
      $.get(Wo_Ajax_Requests_File(), {f:'cancel_call'}, function (data) {});
      location.href = "<?php echo($wo['config']['site_url']) ?>";
    });
  });
  room.on('participantDisconnected', function(participant) {
    console.log(participant.identity + ' left the Room');
    $.get(Wo_Ajax_Requests_File(), {f:'cancel_call'}, function (data) {});
    location.href = "<?php echo($wo['config']['site_url']) ?>";
  });
  
  $(document).on('click', 'a[data-ajax]', function(e) {
    $.get(Wo_Ajax_Requests_File(), {f:'cancel_call'}, function (data) {});
      room.disconnect();
  });
  $(document).on('click', '.decline-call', function(e) {
    $.get(Wo_Ajax_Requests_File(), {f:'cancel_call'}, function (data) {});
      room.disconnect();
  });
});
 
function participantConnected(participant) {
  console.log('Participant "%s" connected', participant.identity);
 
  const div = document.createElement('div');
  div.id = participant.sid;
  //div.innerText = participant.identity;
  participant.tracks.forEach(publication => {
    if (publication.isSubscribed) {
      const track = publication.track;
      div.appendChild(track.attach());
    }
  });
  participant.on('trackSubscribed', track => {
    /*$('#remote-media').html('');*/
    document.getElementById('remote-media').appendChild(track.attach());
  });
 
  $('#remote-media').html(div);
}
</script>
<?php } ?>