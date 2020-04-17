const express = require('express');
const UserController = require('./app/controllers/UserController');
const SessionController = require('./app/controllers/SessionController');
const GuestController = require('./app/controllers/GuestController');
const GuestSessionController = require('./app/controllers/GuestSessionController');
const BeaconController = require('./app/controllers/BeaconController');

const routes = express.Router();

// ROTAS DE USUÁRIOS

routes.post('/users', UserController.store);
routes.get('/users', UserController.index);
routes.put('/users/:id', UserController.update);
routes.delete('/users/:id', UserController.delete);

// ROTAS DE LOGIN

routes.post('/sessions', SessionController.store);
routes.post('/guestsessions', GuestSessionController.store);

// ROTA PARA INSERIR A DATA DE LOGIN NO BANCO DE DADOS (APENAS MOBILE)

routes.get('/guestsessions', GuestSessionController.index);

// ROTAS DE VISITANTES

routes.post('/guests', GuestController.store);
routes.get('/guests', GuestController.index);
routes.get('/guests/:id', GuestController.indexById);
routes.put('/guests/:id', GuestController.update);
routes.delete('/guests/:id', GuestController.delete);

// ROTAS DOS BEACONS

routes.post('/beacons', BeaconController.store);
routes.get('/beacons', BeaconController.index);
routes.get('/beacons/:id', BeaconController.indexById);
routes.put('/beacons/:id', BeaconController.update);
routes.delete('/beacons/:id', BeaconController.delete);

module.exports = routes;
