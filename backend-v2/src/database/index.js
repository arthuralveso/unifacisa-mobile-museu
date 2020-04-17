const Sequelize = require('sequelize');

const User = require('../app/models/User');
const Guest = require('../app/models/Guest');
const Dates = require('../app/models/Dates');
const Beacon = require('../app/models/Beacon');

const configDatabase = require('../config/database');

const models = [User, Guest, Dates, Beacon];

class Database {
  constructor() {
    this.init();
  }

  init() {
    this.connection = new Sequelize(configDatabase);

    models
      .map((model) => model.init(this.connection))
      .map(
        (model) => model.associate && model.associate(this.connection.models)
      );
  }
}

module.exports = new Database();
