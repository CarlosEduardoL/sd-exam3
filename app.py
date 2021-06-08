from flask import Flask, render_template_string, request, session, redirect, url_for
from flask.helpers import url_for
import redis 

app = Flask(__name__)
redisClient = redis.StrictRedis(host='localhost',

                                port=6379,

                                db=0)


@app.route('/', methods=['GET', 'POST'])
def hello():
    if request.method == 'POST':

        a = request.form['country']
        b = request.form['capital']
        redisClient.hset("capital", "a", "b")
        
        print ("Se guardo"+redisClient.hgetall("capital"))

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
    count = 1
    return 'Hello World! I have been seen {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)

