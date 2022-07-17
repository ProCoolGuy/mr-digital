/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Job', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    title: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    location: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    lat: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    lng: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    minimum: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "0"
    },
    maximum: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "0"
    },
    salary_date: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    job_type: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    category: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    question_one: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    question_one_type: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    question_one_answers: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    question_two: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    question_two_type: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    question_two_answers: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    question_three: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    question_three_type: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    question_three_answers: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    image: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    image_type: {
      type: DataTypes.STRING(11),
      allowNull: false,
      defaultValue: ""
    },
    currency: {
      type: DataTypes.STRING(11),
      allowNull: false,
      defaultValue: "0"
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1
    },
    time: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    tableName: 'Wo_Job'
  });
};
