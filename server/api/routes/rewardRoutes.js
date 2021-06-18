module.exports = function(app) {
    const rewards = require('../controllers/rewardController');

    // reward Routes

    app.route('/rewards')
        .get(rewards.list_all_rewards)
        .post(rewards.create_a_reward);

    app.route('/rewards/:rewardId')
        .get(rewards.read_a_reward)
        .put(rewards.update_a_reward)
        .delete(rewards.delete_a_reward);
};
