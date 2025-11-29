from db import r

from pydantic import BaseModel, Field
from typing import Optional, List

class User(BaseModel):
    id: str
    name: str
    age: int
    email: Optional[str] = None
    tags: List[str] = Field(default_factory=list)

def save_user(user: User):
    """Store user in JSON."""
    r.execute_command("JSON.SET", f"user:{user.id}", "$", user.model_dump_json())

def get_user(user_id: str) -> User:
    """Retrieve and fetch user."""
    json_str = r.execute_command("JSON.GET", f"user:{user_id}")
    return User.model_validate_json(json_str)

def update_age(user_id: str, new_age: int):
    """Update a specific field."""
    r.execute_command("JSON.SET", f"user:{user_id}", "$.age", new_age)

def delete_user(user_id: str):
    """Remove user"""
    r.delete(f"user:{user_id}")


alice = User(id="1", name="Alice", age=30, email="alice@example.com", tags=["admin", "beta"])
save_user(alice)
print("✅ Stored user 1")

robert = User.model_validate_json('{"id":"2","name":"Robert","age":40,"email":"robert@example.com","tags":["alpha"]}')
save_user(robert)
print("✅ Stored user 2")

u1 = get_user("1")
print("👤 User 1 from Redis :", u1)
print("Name :", u1.name, "| Age :", u1.age)

u2 = get_user("2")
print("👤 User 2 from Redis :", u2)

update_age("1", 31)
print("🧓 Updated age for user 1 :", get_user("1").age)

delete_user("1")
print("🚮 user:1 exists ?", r.exists("user:1"))

