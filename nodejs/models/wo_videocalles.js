/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_VideoCalles', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    access_token: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    access_token_2: {
      type: DataTypes.TEXT,
      allowNull: true
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
    room_name: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    active: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    called: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    declined: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_VideoCalles'
  });
};
