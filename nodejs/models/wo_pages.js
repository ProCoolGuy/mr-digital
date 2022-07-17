/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Pages', {
    page_id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_name: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    page_title: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    page_description: {
      type: DataTypes.STRING(1000),
      allowNull: false,
      defaultValue: ""
    },
    avatar: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: "upload/photos/d-page.jpg"
    },
    cover: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: "upload/photos/d-cover.jpg"
    },
    users_post: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_category: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    sub_category: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    website: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    facebook: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    google: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    vk: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    twitter: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    linkedin: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    company: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    phone: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    address: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    call_action_type: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    call_action_type_url: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    background_image: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    background_image_status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    instgram: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    youtube: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    verified: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    },
    registered: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: "0/0000"
    },
    boosted: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_Pages'
  });
};
