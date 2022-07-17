module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Mute', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    },
    message_id: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    },
    chat_id: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    },
    notify: {
      type: DataTypes.STRING(5),
      allowNull: true,
      defaultValue: 'yes'
    },
    call_chat: {
      type: DataTypes.STRING(5),
      allowNull: true,
      defaultValue: 'yes'
    },
    archive: {
      type: DataTypes.STRING(5),
      allowNull: true,
      defaultValue: 'yes'
    },
    pin: {
      type: DataTypes.STRING(5),
      allowNull: true,
      defaultValue: 'no'
    },
    fav: {
      type: DataTypes.STRING(11),
      allowNull: true,
      defaultValue: 'no'
    },
    type: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    timestamps: false,
    tableName: 'Wo_Mute'
  });
};