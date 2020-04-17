module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('beacons', {
      id: {
        type: Sequelize.STRING,
        allowNull: false,
        primaryKey: true,
      },
      content_name: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      content_type: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      content: {
        type: Sequelize.STRING(500),
        allowNull: false,
      },
      content_description: {
        type: Sequelize.STRING(256),
        allowNull: false,
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
    });
  },

  down: (queryInterface) => {
    return queryInterface.dropTable('beacons');
  },
};
