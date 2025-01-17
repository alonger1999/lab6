from flask import Flask, render_template, request


app = Flask(__name__)

REASONS = {
    'agression': "Збройна агресія",
    'disaster': "Стихійне лихо"
}

items = []


@app.route('/', methods=['GET', 'POST'])
def index():

    if request.method == 'POST':

        if 'add' in request.form:
            
            name = request.form['name'].strip()
            amount = request.form['amount'].strip()
            reason = request.form['reason'].strip()

            if name and amount and reason:
                items.append({
                    'name': name,
                    'amount': amount,
                    'reason': REASONS.get(reason)
                })

        elif 'clear' in request.form:
            items.clear()

    return render_template('index.html', items=items)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9090, debug=True)
