/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_BlogMovieLikes', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    blog_comm_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    blog_commreply_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    movie_comm_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    movie_commreply_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    blog_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    movie_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_BlogMovieLikes'
  });
};
