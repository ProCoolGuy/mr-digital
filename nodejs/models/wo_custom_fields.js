/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Custom_Fields', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    type: {
      type: DataTypes.STRING(50),
      allowNull: true,
      defaultValue: ""
    },
    length: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    placement: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    required: {
      type: DataTypes.STRING(11),
      allowNull: false,
      defaultValue: "on"
    },
    options: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    active: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    }
  }, {
    sequelize,
    tableName: 'Wo_Custom_Fields'
  });
};
