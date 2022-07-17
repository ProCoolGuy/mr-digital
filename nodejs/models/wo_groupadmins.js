/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_GroupAdmins', {
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
    group_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    general: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    privacy: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    avatar: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    members: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    analytics: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    delete_group: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_GroupAdmins'
  });
};
