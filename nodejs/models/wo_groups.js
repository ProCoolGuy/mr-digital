/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Groups', {
    id: {
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
    group_name: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: ""
    },
    group_title: {
      type: DataTypes.STRING(40),
      allowNull: false,
      defaultValue: ""
    },
    avatar: {
      type: DataTypes.STRING(120),
      allowNull: false,
      defaultValue: "upload/photos/d-group.jpg "
    },
    cover: {
      type: DataTypes.STRING(120),
      allowNull: false,
      defaultValue: "upload/photos/d-cover.jpg  "
    },
    about: {
      type: DataTypes.STRING(550),
      allowNull: false,
      defaultValue: ""
    },
    category: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    sub_category: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    privacy: {
      type: DataTypes.ENUM('1','2'),
      allowNull: false,
      defaultValue: "1"
    },
    join_privacy: {
      type: DataTypes.ENUM('1','2'),
      allowNull: false,
      defaultValue: "1"
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
    }
  }, {
    sequelize,
    tableName: 'Wo_Groups'
  });
};
