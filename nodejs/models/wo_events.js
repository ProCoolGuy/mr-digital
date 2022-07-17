/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Events', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(150),
      allowNull: false,
      defaultValue: ""
    },
    location: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    start_date: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    start_time: {
      type: DataTypes.TIME,
      allowNull: false
    },
    end_date: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    end_time: {
      type: DataTypes.TIME,
      allowNull: false
    },
    poster_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    cover: {
      type: DataTypes.STRING(500),
      allowNull: false,
      defaultValue: "upload/photos/d-cover.jpg"
    }
  }, {
    sequelize,
    tableName: 'Wo_Events'
  });
};
