/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Affiliates_Requests', {
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
    amount: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: "0"
    },
    full_amount: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    iban: {
      type: DataTypes.STRING(250),
      allowNull: false,
      defaultValue: ""
    },
    country: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    full_name: {
      type: DataTypes.STRING(150),
      allowNull: false,
      defaultValue: ""
    },
    swift_code: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    address: {
      type: DataTypes.STRING(600),
      allowNull: false,
      defaultValue: ""
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_Affiliates_Requests'
  });
};
