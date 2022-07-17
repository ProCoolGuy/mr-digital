/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_AgoraVideoCall', {
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
    to_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    type: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "video"
    },
    room_name: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "0"
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    status: {
      type: DataTypes.STRING(20),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    tableName: 'Wo_AgoraVideoCall'
  });
};
