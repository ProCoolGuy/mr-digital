/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Forums', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    sections: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    posts: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    last_post: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_Forums'
  });
};
