from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def home():
    result = ""
    reasoning = ""
    user_input = ""

    if request.method == 'POST':
        names = request.form['names'].lower().replace(" ", "")
        items = request.form['items'].lower().replace(" ", "")
        constraints = request.form['constraints'].lower().splitlines()

        constraint_list = "[" + ",".join([f"'{c.strip()}'" for c in constraints if c.strip()]) + "]"

        user_input = f"""
Names: {names}
Items: {items}
Constraints:
{chr(10).join(constraints)}
"""

        query = f"solve_puzzle([{names}],[{items}],{constraint_list},R),write(R),halt."

        output = subprocess.run(
            ['swipl', '-s', 'solver.pl', '-g', query],
            capture_output=True,
            text=True
        )

        result = output.stdout if output.stdout else "No solution found"

        reasoning = """
Step 1: User entered dynamic data
Step 2: Flask created Prolog query
Step 3: Prolog generated permutations
Step 4: Dynamic constraints checked
Step 5: Final valid solution returned
"""

    return render_template(
        'index.html',
        result=result,
        reasoning=reasoning,
        user_input=user_input
    )

if __name__ == '__main__':
    app.run(debug=True)