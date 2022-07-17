/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Products', {
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
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    category: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    sub_category: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    price: {
      type: DataTypes.STRING(32),
      allowNull: false,
      defaultValue: "0.00"
    },
    location: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    type: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false
    },
    currency: {
      type: DataTypes.STRING(40),
      allowNull: false,
      defaultValue: "USD"
    },
    lng: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: "0"
    },
    lat: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: "0"
    },
    time: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    active: {
      type: DataTypes.ENUM('0','1'),
      allowNull: false,
      defaultValue: "0"
    }
  }, {
    sequelize,
    tableName: 'Wo_Products'
  });
};
