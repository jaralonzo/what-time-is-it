package com.getbux.assignment

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.request.*
import io.ktor.routing.*
import io.ktor.http.*
import io.ktor.html.*
import kotlinx.html.*
import io.ktor.server.testing.*
import org.junit.Test
import org.junit.Assert.assertEquals

class ApplicationTest {
    @Test
    fun testRoot() {
        withTestApplication({ module(testing = true) }) {
            handleRequest(HttpMethod.Get, "/amsterdam").apply {
                assertEquals(HttpStatusCode.OK, response.status())
            }
        }
    }
}
