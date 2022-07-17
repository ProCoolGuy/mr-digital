/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('bank_receipts', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    },
    fund_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    description: {
      type: "TINYTEXT",
      allowNull: false
    },
    price: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "0"
    },
    mode: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    approved: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    },
    receipt_file: {
      type: DataTypes.STRING(250),
      allowNull: false,
      defaultValue: ""
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    },
    approved_at: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'bank_receipts'
  });
};
