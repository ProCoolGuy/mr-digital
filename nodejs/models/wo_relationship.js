/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Relationship', {
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
    relationship: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    }
  }, {
    sequelize,
    tableName: 'Wo_Relationship'
  });
};
