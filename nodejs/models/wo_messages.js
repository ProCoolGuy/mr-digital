/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Messages', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    from_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    group_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    to_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    text: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    media: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: ""
    },
    mediaFileName: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    mediaFileNames: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    seen: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    deleted_one: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    },
    deleted_two: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    },
    sent_push: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    notification_id: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    type_two: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    stickers: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    product_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    lat: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: "0"
    },
    lng: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: "0"
    },
    reply_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    story_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_Messages'
  });
};
