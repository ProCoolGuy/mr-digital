/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Config', {
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
    value: {
      type: DataTypes.STRING(20000),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_Config'
  });
};
