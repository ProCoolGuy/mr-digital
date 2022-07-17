/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_UserStory', {
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
    title: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    posted: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    expire: {
      type: DataTypes.STRING(100),
      allowNull: true,
      defaultValue: ""
    },
    thumbnail: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_UserStory'
  });
};
