/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_GroupChat', {
    group_id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    group_name: {
      type: DataTypes.STRING(20),
      allowNull: false,
      defaultValue: ""
    },
    avatar: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: "upload/photos/d-group.jpg"
    },
    time: {
      type: DataTypes.STRING(30),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_GroupChat'
  });
};
