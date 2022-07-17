/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Games', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    game_name: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    game_avatar: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    game_link: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "1"
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_Games'
  });
};
