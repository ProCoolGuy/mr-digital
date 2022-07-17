/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_ProfileFields', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    type: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    length: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    placement: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: "profile"
    },
    registration_page: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    profile_page: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    select_type: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: "none"
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    }
  }, {
    sequelize,
    tableName: 'Wo_ProfileFields'
  });
};
