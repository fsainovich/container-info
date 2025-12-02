import os

from flask import Flask, render_template
from flask_wtf.csrf import CSRFProtect

app = Flask(__name__)
csrf = CSRFProtect()
csrf.init_app(app)

data = {}

@app.route('/')
def index():

    env_vars=os.environ.items()
    config = os.getenv('CONFIG').split(",")
    config_upper = [s.upper() for s in config]
    print("ENV_VARS:", env_vars)
    if config_upper:
        print("CONFIG is present:", config_upper)
        for k, v in env_vars:            
            if k.upper() in config_upper:
                data[k.upper()]=v                
            else:
                continue
        print(data)
        return render_template('index.html', envvar=data )
    else:
        for k, v in env_vars:        
            match k:
                case "HOSTNAME":
                    data[k]=v
                case "USER":
                    data[k]=v
                case _:
                    continue            
        return render_template('index.html', envvar=data )

if __name__ == "__main__":
    app.run(host='0.0.0.0')