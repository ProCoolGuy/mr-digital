/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Forum_Sections', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    section_name: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.STRING(300),
      allowNull: true,
      defaultValue: ""
    }
  }, {
    sequelize,
    tableName: 'Wo_Forum_Sections'
  });
};
