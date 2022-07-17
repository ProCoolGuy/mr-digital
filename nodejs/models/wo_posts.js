/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Posts', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    post_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    recipient_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    postText: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    group_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    event_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_event_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    postLink: {
      type: DataTypes.STRING(1000),
      allowNull: false,
      defaultValue: ""
    },
    postLinkTitle: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    postLinkImage: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    postLinkContent: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    postVimeo: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    postDailymotion: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    postFacebook: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    postFile: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postFileName: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    postFileThumb: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: ""
    },
    postYoutube: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postVine: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    postSoundCloud: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postPlaytube: {
      type: DataTypes.STRING(500),
      allowNull: false,
      defaultValue: ""
    },
    postDeepsound: {
      type: DataTypes.STRING(500),
      allowNull: false,
      defaultValue: ""
    },
    postMap: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postShare: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    postPrivacy: {
      type: DataTypes.ENUM('0','1','2','3','4'),
      allowNull: false,
      defaultValue: "1"
    },
    postType: {
      type: DataTypes.STRING(30),
      allowNull: false,
      defaultValue: ""
    },
    postFeeling: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postListening: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postTraveling: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postWatching: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postPlaying: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    postPhoto: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: ""
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    registered: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: "0/0000"
    },
    album_name: {
      type: DataTypes.STRING(52),
      allowNull: false,
      defaultValue: ""
    },
    multi_image: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    },
    multi_image_post: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    boosted: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    product_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    poll_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    blog_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    forum_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    thread_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    videoViews: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    postRecord: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: ""
    },
    postSticker: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    shared_from: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    post_url: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    parent_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    cache: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    comments_status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    blur: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    color_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    job_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    offer_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    fund_raise_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    fund_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    active: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    stream_name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    live_time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    live_ended: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    agora_resource_id: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    agora_sid: {
      type: DataTypes.STRING(500),
      allowNull: false,
      defaultValue: ""
    },
    send_notify: {
      type: DataTypes.STRING(11),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    tableName: 'Wo_Posts'
  });
};
