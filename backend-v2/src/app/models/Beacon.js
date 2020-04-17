const { Model } = require('sequelize');
const Sequelize = require('sequelize');

class Beacon extends Model {
  static init(sequelize) {
    super.init(
      {
        id: {
          type: Sequelize.STRING,
          primaryKey: true,
        },
        content_name: Sequelize.STRING,
        content_type: Sequelize.STRING,
        content: Sequelize.STRING,
        content_description: Sequelize.STRING,
      },
      {
        sequelize,
      }
    );

    return this;
  }
}

module.exports = Beacon;
