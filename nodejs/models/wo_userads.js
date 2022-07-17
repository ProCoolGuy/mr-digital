/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_UserAds', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    url: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: ""
    },
    headline: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    location: {
      type: DataTypes.STRING(1000),
      allowNull: false,
      defaultValue: "us"
    },
    audience: {
      type: "LONGTEXT",
      allowNull: true
    },
    ad_media: {
      type: DataTypes.STRING(3000),
      allowNull: false,
      defaultValue: ""
    },
    gender: {
      type: DataTypes.STRING(15),
      allowNull: false,
      defaultValue: "all"
    },
    bidding: {
      type: DataTypes.STRING(15),
      allowNull: false,
      defaultValue: ""
    },
    clicks: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    views: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    posted: {
      type: DataTypes.STRING(15),
      allowNull: false,
      defaultValue: ""
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    appears: {
      type: DataTypes.STRING(10),
      allowNull: false,
      defaultValue: "post"
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_id: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    start: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    end: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    budget: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0
    },
    spent: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'Wo_UserAds'
  });
};
