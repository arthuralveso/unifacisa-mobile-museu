const jwt = require('jsonwebtoken');
const Yup = require('yup');
const User = require('../models/User');
const authConfig = require('../../config/auth');

class SessionController {
  /** METODO PARA LOGIN DE USUÁRIO. FAZ AS VALIDAÇÕES E RETORNA OS DADOS
   * DO USUÁRIO(ID, NOME, EMAIL, E PROVIDER(SE É ADMNISTRADOR OU NÃO))
   * */

  async store(req, res) {
    const schema = Yup.object().shape({
      username: Yup.string().required(),
      password: Yup.string().required(),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }
    const { username, password } = req.body;

    const user = await User.findOne({ where: { username } });
    if (!user) {
      return res.status(401).json({ error: 'User not found' });
    }
    if (!(await user.checkpassword(password))) {
      return res.status(401).json({ error: 'Password does not match' });
    }

    const { id, name, email, provider } = user;

    return res.json({
      user: {
        id,
        name,
        email,
        provider,
      },
      token: jwt.sign({ id }, authConfig.secret, {
        expiresIn: authConfig.expiresIn,
      }),
    });
  }
}

module.exports = new SessionController();
