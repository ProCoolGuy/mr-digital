/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Langs', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    lang_key: {
      type: DataTypes.STRING(160),
      allowNull: true
    },
    type: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    english: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    arabic: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    dutch: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    french: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    german: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    italian: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    portuguese: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    russian: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    spanish: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    turkish: {
      type: DataTypes.TEXT,
      allowNull: true
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_Langs'
  });
};
