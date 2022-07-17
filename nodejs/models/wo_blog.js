/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Blog', {
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
    title: {
      type: DataTypes.STRING(120),
      allowNull: false,
      defaultValue: ""
    },
    content: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    posted: {
      type: DataTypes.STRING(300),
      allowNull: true,
      defaultValue: "0"
    },
    category: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    thumbnail: {
      type: DataTypes.STRING(100),
      allowNull: true,
      defaultValue: "upload/photos/d-blog.jpg"
    },
    view: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    shared: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    tags: {
      type: DataTypes.STRING(300),
      allowNull: true,
      defaultValue: ""
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "1"
    }
  }, {
    sequelize,
    tableName: 'Wo_Blog'
  });
};
