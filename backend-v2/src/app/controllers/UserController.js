const Yup = require('yup');
const User = require('../models/User');

class UserController {
  // CRIAÇÃO DE USUÁRIO, CAMPOS: NOME, USUÁRIO, EMAIL E SENHA

  async store(req, res) {
    const schema = Yup.object().shape({
      name: Yup.string().required(),
      username: Yup.string().required(),
      email: Yup.string().email().required(),
      password: Yup.string().required(),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }
    const userExists = await User.findOne({
      where: { username: req.body.username },
    });
    if (userExists) {
      return res.status(400).json({ error: 'Username already exists.' });
    }

    const { id, name, username, email, provider } = await User.create(req.body);

    return res.json({
      id,
      name,
      username,
      email,
      provider,
    });
  }

  // LISTAGEM DE USUÁRIO
  async index(req, res) {
    const getUser = await User.findAll({
      attributes: ['id', 'name', 'username', 'email', 'provider'],
    });

    return res.json(getUser);
  }

  // ATUALIZA USUÁRIO. CAMPOS: NOME, USUÁRIO, SENHA, EMAIL E PROVIDER
  async update(req, res) {
    const schema = Yup.object().shape({
      name: Yup.string(),
      username: Yup.string(),
      password: Yup.string(),
      email: Yup.string().email(),
      provider: Yup.boolean(),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }

    const { username } = req.body;

    const user = await User.findByPk(req.params.id);

    if (username !== user.username) {
      const userExists = await User.findOne({
        where: { username: req.body.username },
      });
      if (userExists) {
        return res.status(400).json({ error: 'Username already exists.' });
      }
    }
    const { name, email, provider } = await user.update(req.body);

    return res.json({
      name,
      username,
      email,
      provider,
    });
  }

  // DELETA USUÁRIOS A PARTIR DO ID
  async delete(req, res) {
    const user = await User.destroy({
      where: { id: req.params.id },
    });

    if (!user) {
      return res.status(500).json({ error: 'User do not exists' });
    }

    return res.status(200).json('User Deleted');
  }
}

module.exports = new UserController();
