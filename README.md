## Haystack Worker

Works on behalf of a haystack server.

## Concept

A haystack worker's sole responsibility is to calculate surpluses of characters that satisfy self-enumerating pangrams. It does this as quickly as possible and therefore makes use of a C-extension for a ~200x speed increase over Ruby.

It receives 'jobs' from a haystack server which come in the form:

```ruby
{ 'id' => 123, 'from' => [1, 3, 8, etc], 'to' => [10, 4, 14, etc] }
```

The 'from' and 'to' arrays represent the search space that this worker has been assigned to explore. The ID is used by the haystack worker to keep track of jobs.

It posts data back to the haystack at /job/:id in the form:

```ruby
[[1,3,8,etc],[6,4,14,etc]]
```

It returns an empty array if the given search space doesn't contain any potential self-enumerating pangrams.

## Usage

```
gem install haystack_worker
haystack worker haystack.example.com
```

At present, I haven't built the haystack server. When I have, I'll update the gem to point to it by default.

## Resources

For more information or to gain some context, please see my pangram and frequency related projects.
