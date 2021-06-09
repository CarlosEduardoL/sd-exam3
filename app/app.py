from re import template
from flask import Flask, render_template_string, request, session, redirect, url_for
from flask.helpers import url_for
import redis

#Creates the Flask instance.
#__name__ is the name of the current Python module. The app needs to know where it’s located to set up some paths, and __name__ is a convenient way to tell it that.
app = Flask(__name__)

#The connection with the database with the host primary.sd-exam3.svc.cluster.local
redisClient = redis.StrictRedis(
    host='primary.sd-exam3.svc.cluster.local', db=0)

#Create the route /postcapital and has a UI that POST a country name and the capital of the country to save in the Redis database in a HashMap "capital" 
#If has a POST request the method create a new element in the HashMap and redirect to the main route, else show the UI webpage
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

#The main route that GET the HashMap "capital" that was stored in the Redis database
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
#The route /health give a 200 request if the Database is up
@app.route('/health')
def health():
    response = app.response_class(
        status=200,
    )
    return response
#Run the web page on port 8000 in any IP address that the machine has configured
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
