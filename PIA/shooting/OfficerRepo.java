package com.sullexis.text.tools.shooting;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface OfficerRepo extends MongoRepository<Officer, ObjectId> {
}
