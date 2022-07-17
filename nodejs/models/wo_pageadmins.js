/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_PageAdmins', {
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
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    general: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    info: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    social: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    avatar: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    design: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    admins: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    analytics: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    delete_page: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_PageAdmins'
  });
};
