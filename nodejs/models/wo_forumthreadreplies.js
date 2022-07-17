/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_ForumThreadReplies', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    thread_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    forum_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    poster_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    post_subject: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    post_text: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    post_quoted: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    posted_time: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'Wo_ForumThreadReplies'
  });
};
