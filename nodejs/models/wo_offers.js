/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Offers', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    discount_type: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    discount_percent: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    discount_amount: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    discounted_items: {
      type: DataTypes.STRING(150),
      allowNull: true,
      defaultValue: ""
    },
    buy: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    get_price: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    spend: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    amount_off: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    expire_date: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    expire_time: {
      type: DataTypes.TIME,
      allowNull: false
    },
    image: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    currency: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_Offers'
  });
};
