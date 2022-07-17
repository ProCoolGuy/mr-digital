/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Wo_Job_Apply', {
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
    job_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    page_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    user_name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    phone_number: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    location: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    email: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    question_one_answer: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    question_two_answer: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    question_three_answer: {
      type: DataTypes.STRING(200),
      allowNull: false,
      defaultValue: ""
    },
    position: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    where_did_you_work: {
      type: DataTypes.STRING(100),
      allowNull: false,
      defaultValue: ""
    },
    experience_description: {
      type: DataTypes.STRING(300),
      allowNull: false,
      defaultValue: ""
    },
    experience_start_date: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    experience_end_date: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    },
    time: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: ""
    }
  }, {
    sequelize,
    tableName: 'Wo_Job_Apply'
  });
};
