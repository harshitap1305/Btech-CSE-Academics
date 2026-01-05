def value_iteration(states, actions, T, C, goal_state, gamma=0.95, epsilon=0.001):
    V = {s: 0 for s in states}
    iteration = 0

    while True:
        delta = 0
        V_new = V.copy()
        for s in states:
            if s == goal_state:
                continue

            action_values = []
            for a in actions[s]:
                total = 0
                for s_next, prob in T[(s, a)].items():
                    total += prob * (C[(s, a, s_next)] + gamma * V[s_next])
                action_values.append(total)

            V_new[s] = min(action_values)
            delta = max(delta, abs(V_new[s] - V[s]))

        V = V_new
        iteration += 1
        if delta < epsilon:
            break

    policy = {}
    for s in states:
        if s == goal_state:
            policy[s] = None
            continue
        best_action = None
        best_value = float('inf')
        for a in actions[s]:
            total = sum(T[(s, a)][s_next] * (C[(s, a, s_next)] + gamma * V[s_next]) for s_next in T[(s, a)])
            if total < best_value:
                best_value = total
                best_action = a
        policy[s] = best_action

    return V, policy, iteration


# Define MDP
states = ['A', 'B', 'C', 'D', 'E', 'G']
actions = {
    'A': ['a1', 'a2'],
    'B': ['a1', 'a2'],
    'C': ['a1'],
    'D': ['a1'],
    'E': ['a1'],
    'G': []
}
T = {
    ('A', 'a1'): {'B': 0.7, 'C': 0.3},
    ('A', 'a2'): {'C': 0.6, 'D': 0.4},
    ('B', 'a1'): {'C': 0.8, 'E': 0.2},
    ('B', 'a2'): {'D': 1.0},
    ('C', 'a1'): {'E': 0.9, 'G': 0.1},
    ('D', 'a1'): {'E': 0.7, 'G': 0.3},
    ('E', 'a1'): {'G': 1.0}
}
C = {}
for (s, a), transitions in T.items():
    for s_next in transitions:
        C[(s, a, s_next)] = 2 + 0.2 * (hash(s + s_next + a) % 3)

V, policy, iters = value_iteration(states, actions, T, C, 'G')
print("Value Iteration Results:")
print("Iterations:", iters)
print("State Values:", V)
print("Optimal Policy:", policy)
