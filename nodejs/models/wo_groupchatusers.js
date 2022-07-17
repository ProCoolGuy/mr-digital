/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_GroupChatUsers', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    group_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    active: {
      type: DataTypes.ENUM('1','0'),
      allowNull: false,
      defaultValue: "1"
    },
    last_seen: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "0"
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_GroupChatUsers'
  });
};
