/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Apps', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    app_user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    app_name: {
      type: DataTypes.STRING(32),
      allowNull: false
    },
    app_website_url: {
      type: DataTypes.STRING(55),
      allowNull: false
    },
    app_description: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    app_avatar: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: "upload/photos/app-default-icon.png"
    },
    app_callback_url: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    app_id: {
      type: DataTypes.STRING(32),
      allowNull: false
    },
    app_secret: {
      type: DataTypes.STRING(55),
      allowNull: false
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "1"
    }
  }, {
    sequelize,
    tableName: 'Wo_Apps'
  });
};
