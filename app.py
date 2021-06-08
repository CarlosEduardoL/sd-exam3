from re import template
from flask import Flask, render_template_string, request, session, redirect, url_for
from flask.helpers import url_for
import redis

app = Flask(__name__)
redisClient = redis.StrictRedis(
    host='primary.sd-exam3.svc.cluster.local', db=0)


@app.route('/postcapital', methods=['GET', 'POST'])
def POST():
    if request.method == 'POST':

        a = request.form['country']
        b = request.form['capital']
        redisClient.hset("capital", a, b)

        app.logger.info(redisClient.hgetall("capital"))

        return redirect(url_for('principal'))

    return render_template_string("""<form method="post">
            <label for="email">Enter the country:</label>
            <input type="text" id="country" name="country" required />
            <label for="email">enter the capital:</label>
            <input type="text" id="capital" name="capital" required />
            <button type="submit">Submit</button
        </form>
        """)


@app.route('/')
def principal():
    capitals = redisClient.hgetall("capital")
    return render_template_string("""<table>
        {% for key in capitals %}
         <tr>
            <th> {{ key }} </th>
            <td> {{ capitals[key] }} </td>
         </tr>
        {% endfor %}
        </table>""",capitals=capitals)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
