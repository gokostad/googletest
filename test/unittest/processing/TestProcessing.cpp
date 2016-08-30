#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace ::testing;

class TestProcessing : public Test
{
public:
    TestProcessing() {}
    virtual ~TestProcessing() {}

protected:
    virtual void SetUp()
    {
    }

private:
    /** Prevents copy construction */
    TestProcessing(const TestProcessing&);
    /** Preventing assingment */
    TestProcessing& operator=(const TestProcessing&);
};

TEST_F(TestProcessing, justTrial)
{
    ASSERT_TRUE(1 == 1);
}
