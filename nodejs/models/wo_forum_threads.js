/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Forum_Threads', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    views: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    headline: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    post: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    posted: {
      type: DataTypes.STRING(20),
      allowNull: false,
      defaultValue: "0"
    },
    last_post: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    forum: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_Forum_Threads'
  });
};
