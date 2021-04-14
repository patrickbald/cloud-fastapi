from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

runners = {}

class Runner(BaseModel):
	name: str
	hometown: str
	miles: float

# ----------------------- GET

@app.get("/")
def read_root():
	return {"message": "Please use an endpoint"}

@app.get("/runners/")
def read_runners():
	return runners

@app.get("/runners/{runner_id}")
def get_runner(runner_id: int):
	global runners
	return runners[runner_id]

# ----------------------- POST (creating runner)

@app.post("/runners/")
async def create_runner(runner: Runner):
	global runners
	key = len(runners)
	if len(runners) in runners:
		key = max(runners) + 1
	runners[key] = runner
	return runner

# ----------------------- PUT (updating runner fully)

@app.put("/runners/{runner_id}", response_model=Runner)
def update_runner(runner_id: int, runner: Runner):
	global runners
	if runner_id not in runners:
		return {"error": "runner not found"}
	runners[runner_id] = runner
	return runner

# ----------------------- PATCH (partial update)

@app.patch("/runners/{runner_id}")
async def patch_runner(runner_id: int, miles: float):
	global runners
	try:
		runners[runner_id].miles += miles
		return runners[runner_id]
	except:
		return {"error": "runner not found"}

# ----------------------- DELETE

@app.delete("/runners/")
async def delete_runners():
	global runners
	runners.clear()
	return {"message": "all runners deleted from database"}

@app.delete("/runners/{runner_id}")
async def delete_runner(runner_id: int):
	global runners
	if runner_id not in runners:
		return {"error": "runner not in database"}
	removed_runner = runners.pop(runner_id)
	return {'removed runner': removed_runner}
